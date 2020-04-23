class VariableService
	class << self
		def pedestal_events
			(0...SetupEventService::PED_ROWS*SetupEventService::PED_COLS).map do |i|
				$game_variables[300 + i]
			end
		end

		def set_pedestal_event(pedestal_id, event_id)
  		$game_variables[300 + pedestal_id] = event_id
		end

		def pedestal_items
			(0...SetupEventService::PED_ROWS*SetupEventService::PED_COLS).map do |i|
				$game_variables[100 + i]
			end
		end

		def set_pedestal_item(pedestal_id, item_id)
  		$game_variables[100 + pedestal_id] = item_id
		end

		def item_taken?(item_id)
			$game_variables[50 + item_id] == 1
		end

		def set_item_taken(item_id, boolean)
			$game_variables[50 + item_id] = boolean ? 1 : 0
		end

		FLAGS = %w[
			nothing

			knows_what_golem_is
			curious_about_golem
			has_wand
			golem_reinited
			golem_should_stop
			golem_activated
		]
		
		FLAGS.each_with_index do |name, idx|
			define_method "#{name}?".to_sym do
				$game_variables[idx] == 1
			end

			define_method "#{name}=".to_sym do |value|
				$game_variables[idx] = value ? 1 : 0
			end

			define_method "#{name}_index".to_sym do |value|
				idx
			end
		end

		NUMBERS = %w[
			golem_step
		]

		NUMBERS.each_with_index do |name, idx|
			define_method "#{name}".to_sym do
				$game_variables[idx]
			end

			define_method "#{name}=".to_sym do |value|
				$game_variables[idx] = value
			end

			define_method "#{name}_index".to_sym do |value|
				idx
			end
		end
	end
end
