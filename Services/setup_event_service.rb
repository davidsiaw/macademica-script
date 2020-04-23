class SetupEventService
	def setup!

		puts "map:", $game_map.map_id
		update_pedestals!
		update_events!

		$last_game_map = $game_map.map_id
	end

	def create_pedestal(x, y)
		id = $game_map.events.empty? ? 1 : $game_map.events.keys.max + 1
		ev = RPG::Event.new(x, y)

		page = RPG::Event::Page.new
		page.trigger = 0
		gen = Listing::Generator.new do
			script "PedestalService.new(#{id}, self).run!"
		end
		page.list = gen.result
		ev.pages = [page]

		game_ev = Game_Event.new(4, ev)
		$game_map.events[id] = game_ev
		game_ev.refresh
      #code = i%4 == 0 ? 101 : 401
      #command.push(RPG::EventCommand.new(code, @event_id, [result[i]]))}

		return id
	end

	PED_ROWS = 4
	PED_COLS = 6
	def update_pedestals!
		return unless $game_map.map_id == 4

		if $last_game_map != $game_map.map_id
			count = 0
			puts "Initializing pedestals"
			(0...PED_ROWS).each do |y|
			(0...PED_COLS).each do |x|
				event_id = create_pedestal(x * 3 + 2 , y * 3 + 3)
				VariableService.set_pedestal_event(count, event_id)
				puts "event_id #{event_id} is pedestal_id #{count}"
				count += 1
			end
			end
		end

		puts "Updating pedestals"

		VariableService.pedestal_events.each_with_index do |event_id, idx|
			item_id = VariableService.pedestal_items[idx]

			ci = ChangeIconService.new(event_id)
			if item_id != 0
				ci.change!(item_id / 16, item_id % 16)
			else
				ci.remove!
			end
		end
	end

	# Set events according to their on-ness
	def update_events!
		ITEMS.each do |item_sym, item|
			next unless item['map_id'] == $game_map.map_id

			evt = $game_map.events[item['event_id']]
			next unless evt

      key = [item['map_id'], item['event_id'], "A"]
			if VariableService.item_taken?(item['id'])
				$game_self_switches[key] = false
				puts "disabled #{item_sym}"
			else
				$game_self_switches[key] = true
				puts "enabled #{item_sym}"
			end

			VariableService.golem_reinited = true

    	$game_map.need_refresh = true
		end
	end
end
