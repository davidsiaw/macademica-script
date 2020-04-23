ITEMS = {
	"forward_crystal" => { 'id' => 26,  'rmxp_item_id' => 1, 'name' => "Forward Crystal",     'event_id' => 6, 'map_id' => 5 },
	"turn_crystal"    => { 'id' => 27,  'rmxp_item_id' => 2, 'name' => "Turn Crystal",        'event_id' => 7, 'map_id' => 5 },
	"begin_frag"      => { 'id' => 102, 'rmxp_item_id' => 3, 'name' => "Fragment of End",     'event_id' => 8, 'map_id' => 5 },
	"end_frag"        => { 'id' => 103, 'rmxp_item_id' => 4, 'name' => "Fragment of Begin",   'event_id' => 8, 'map_id' => 5 }
}

class ItemService
	def self.item_sym_of(item_id)
		ITEMS.each do |item_sym, item|
			return item_sym if item['id'] == item_id
		end
	end

	def initialize(item_sym, event_id)
		@item_sym = item_sym
		@item = ITEMS[item_sym.to_s]
		@item_id = @item['id']
		@event_id = event_id
	end

	def take!
		name = @item['name']
		$game_party.gain_item(@item['rmxp_item_id'], 1)
		VariableService.set_item_taken(@item_id, true)

    item_event_id = @event_id
		ScriptService.new.run do
			play_se "001-System01"
			message "You pick up a #{name}"

			if $string_inventory == "???"
				$string_inventory = "Inventory"
				play_se "087-Action02"
				message "Inventory menu unlocked!"
			end

			script "$game_map.events[#{item_event_id}].erase"
		end
	end
end
