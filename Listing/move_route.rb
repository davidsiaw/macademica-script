module Listing
	class MoveCommander
		MOVES = {
      1  => :move_down,
      2  => :move_left,
      3  => :move_right,
      4  => :move_up,
      5  => :move_lower_left,
      6  => :move_lower_right,
      7  => :move_upper_left,
      8  => :move_upper_right,
      9  => :move_random,
      10 => :move_toward_player,
      11 => :move_away_from_player,
      12 => :move_forward,
      13 => :move_backward,

      16 => :turn_down,
      17 => :turn_left,
      18 => :turn_right,
      19 => :turn_up,
      20 => :turn_right_90,
      21 => :turn_left_90,
      22 => :turn_180,
      23 => :turn_right_or_left_90,
      24 => :turn_random,
      25 => :turn_toward_player,
      26 => :turn_away_from_player,

      31 => :animate_walk,
      32 => :freeze_walk,
      33 => :animate_step,
      34 => :freeze_step,
      35 => :fix_direction,
      36 => :unfix_direction
		}

		MOVES.each do |code, method_name|
			define_method method_name do
				#p "added #{code} #{method_name}"
				@listing << RPG::MoveCommand.new(code)
			end
		end

		def initialize(&block)
			@listing = []
			instance_eval(&block)
		end

		def jump(x, y)
			@listing << RPG::MoveCommand.new(14, [x, y])
		end

		def result
			@listing + [RPG::MoveCommand.new]
		end
	end

	class MoveRoute
		def apply(options = {}, &block)
			who = get_character_code(options[:for]) || 0
			repeat = options[:repeat] || false
			skippable = options[:skippable] || false

			mc = MoveCommander.new(&block)
			route = RPG::MoveRoute.new
			route.repeat = repeat
			route.skippable = skippable
			route.list = mc.result

			#p route

			[RPG::EventCommand.new(209, 0, [who, route])]
		end

		def get_character_code(value)
			case value
			when :player
				return -1
			when :event
				return 0
			end

			return value
		end
	end
end
