def load_script(name)
  script = File.read("Scripts/#{name}.rb")
  eval script, binding, "Scripts/#{name}.rb"
end

load_script 'debug'

load_script 'Scenes/scene_title'
load_script 'Scenes/scene_credits'
load_script 'Scenes/scene_map'
load_script 'Scenes/scene_menu'
load_script 'Scenes/scene_end'
load_script 'Scenes/scene_item_select'

load_script 'Windows/window_item_select'

load_script 'Services/character_hide_service'
load_script 'Services/change_icon_service'
load_script 'Services/setup_event_service'
load_script 'Services/inspect_service'
load_script 'Services/script_service'
load_script 'Services/variable_service'

load_script 'Services/pedestal_service'
load_script 'Services/golem_service'
load_script 'Services/item_service'
load_script 'Services/book_service'

load_script 'Listing/generator'
load_script 'Listing/condition'
load_script 'Listing/message'
load_script 'Listing/bool_expression'
load_script 'Listing/block_gen'
load_script 'Listing/script'
load_script 'Listing/erase_event'
load_script 'Listing/play_se'
load_script 'Listing/move_route'
load_script 'Listing/repeat'
load_script 'Listing/wait_move_route'
load_script 'Listing/label'
load_script 'Listing/wait'