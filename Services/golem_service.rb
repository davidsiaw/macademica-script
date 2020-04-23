class GolemService
	def run(event_id)
		@golem = event_id
		if VariableService.has_wand?
			return wave_wand!
		end

		if !VariableService.knows_what_golem_is?
			VariableService.curious_about_golem = true
			return ScriptService.new.run do
				message 'I need to get this out of the way'
			end
		end

		ScriptService.new.run do
			message 'I need a [Wand of Command] to move it.'
		end
	end

	def method_missing(name, *args, &block)
		key = name.to_s.sub(/_item$/, '')
		return ITEMS[key]['id'] if ITEMS[key]
		super
	end

	def wave_wand!
		return if VariableService.golem_activated?

		$game_golem_object = self
		ScriptService.new.run do
			message 'abracadabra'

			script '$game_golem_object.execute_crystals!'
		end
	end

	def execute_crystals!
		golem = @golem
		evt = self
		curr_item_idx = 0
		ScriptService.new.run(:parallel => true) do

			condition "var#{VariableService.golem_activated_index}".to_sym, :eq, 0 do

				script 'VariableService.golem_activated = true'
			  script 'p "ACTIVATE GOLEM", VariableService.golem_activated?'

				move_route :for => golem, :skippable => true do
					if VariableService.golem_reinited?
						turn_away_from_player
						VariableService.golem_reinited = false
					end
				end

				loop_contents = nil
				loop do
					curr_item = VariableService.pedestal_items[curr_item_idx]

					if curr_item == evt.begin_frag_item
						loop_contents = []

					elsif curr_item == evt.end_frag_item && loop_contents != nil
						evt.do_loop(loop_contents, evt, self)
						loop_contents = nil

					else
						if loop_contents == nil
							evt.do_things(curr_item, evt, self)
						else
							loop_contents << curr_item
						end
					end

					curr_item_idx += 1
					break if curr_item_idx == VariableService.pedestal_items.length
				end

			  script 'p "DEACTIVATE GOLEM"'
				script 'VariableService.golem_activated = false'
			end

		end
	end

	def do_loop(items, evt, executor)
		$game_golem = @golem
		executor.script('GolemService.start_loop')
		executor.label "aaaa"
		items.each do |item|
			evt.do_things(item, evt, executor)
			executor.wait_move_route
		end
		executor.script('GolemService.track_loop')
		executor.condition "var#{VariableService.golem_should_stop_index}".to_sym, :eq, 0 do
			#script('p "aaa", VariableService.golem_should_stop?')
			goto_label "aaaa"
		end
	end

	def do_things(item, evt, executor)
		golem = @golem
		if item == evt.forward_crystal_item
			executor.move_route(:for => golem, :skippable => true) { move_forward }
		elsif item == evt.turn_crystal_item
			executor.move_route(:for => golem, :skippable => true) { turn_left_90 }
		end
	end

	def self.start_loop
		VariableService.golem_should_stop = false
		$golem_positions = {}
	end

	def self.track_loop
		x = $game_map.events[$game_golem].x
		y = $game_map.events[$game_golem].y
		$golem_positions["#{x},#{y}"] ||= 0
		$golem_positions["#{x},#{y}"] += 1

		$golem_positions.each do |k, v|
			#p "check #{k}"
			if v == 4
				#p "stop because #{k} is #{v}"
				VariableService.golem_should_stop = true
				break
			end
		end
	end

end
