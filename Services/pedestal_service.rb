class PedestalService
	def initialize(event_id, interpreter = nil)
		@event_id = event_id
		@interpreter = interpreter
	end

	def run!
		p "Pedestal #{@event_id}"

		return if $string_inventory == "???"

		# take the item back if its already there
		if pedestal_item_id != 0
			$game_party.gain_item(rmxp_item_id, 1)
			self.pedestal_item_id = 0

			name = item_name
			ScriptService.new.run do
				play_se "001-System01"
				message "You take back the #{name}"
			end
			SetupEventService.new.setup!
			$game_map.need_refresh = true
			return
		end

		if item_count == 0
			ScriptService.new.run do
				play_se '004-System04'
				message 'You do not have anything to put on the pedestal'
			end
			return
		end
    $scene = Scene_Item_Select.new(@event_id)
	end

	def item_count
		count = 0
		$game_party.items.each do |item_id, item_count|
			count += item_count
		end
		count
	end

	def item_sym
		@item_sym ||= ItemService.item_sym_of(pedestal_item_id)
	end

	def item_name
  	ITEMS[item_sym]['name']
	end

	def rmxp_item_id
  	ITEMS[item_sym]['rmxp_item_id']
	end

  def pedestal_id
  	@pedestal_id ||= begin
  		id = 0
  		VariableService.pedestal_events.each_with_index do |event_id, idx|
	  		if event_id == @event_id
	  			puts "event_id #{@event_id} is pedestal_id #{idx}"
	  			id = idx
	  		 	break
	  		end
  		end
	  	id
  	end
  end

  def pedestal_item_id
  	VariableService.pedestal_items[pedestal_id]
  end

  def pedestal_item_id=(value)
  	VariableService.set_pedestal_item(pedestal_id, value)
  end
end