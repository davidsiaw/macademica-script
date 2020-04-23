class ScriptService
	def run(options={}, &block)
		id = $game_map.events.empty? ? 1 : $game_map.events.keys.max + 1
		ev = RPG::Event.new(0, 0)

		page = RPG::Event::Page.new
		if options[:parallel]
			page.trigger = 4
		else
			page.trigger = 3
		end

		gen = Listing::Generator.new do
			instance_eval(&block)
			script "$game_map.events[#{id}].erase"
		end
		page.list = gen.result
		ev.pages = [page]

		game_ev = Game_Event.new(4, ev)
		$game_map.events[id] = game_ev
		game_ev.refresh
	end
end
