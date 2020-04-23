
class ChangeIconService
	def initialize(at_event_id)
		@event_id = at_event_id
	end

	def event
		$game_map.events[@event_id]
	end

	def change!(charmap, framenum)
		event.set_graphic("bits#{charmap}", 0, framenum)
	end

	def remove!
		event.set_graphic("", 0, 0)
	end
end

###### MONKEYS

class Game_Map
  
  Auto_Update = true
  
  # custom graphics 
  def graphic(id)
    case id
    when 1 then return 'LOS-Ethnic05'
    end
  end
  
  alias setup_graphic setup
  def setup(map_id)
    setup_graphic(map_id)
    $game_map.events.each_key {|i|
    graphic_check(i) if $game_map.events[i] != nil}
  end
  
  def graphic_check(event_id)
    event = @map.events[event_id]
    if event.name.clone.gsub!(/\\[Pp]\[(\d+)\]/) {"#[$1]"}
      $game_map.events[event_id].character_name = 
      $game_party.actors[$1.to_i].character_name
      $game_map.events[event_id].refresh
    end
    if event.name.clone.gsub!(/\\[Aa]\[(\d+)\]/) {"#[$1]"}
      $game_map.events[event_id].character_name = 
      $game_actors[$1.to_i].character_name
      $game_map.events[event_id].refresh
    end
    if event.name.clone.gsub!(/\\[Cc]\[(\d+)\]/) {"#[$1]"}
      $game_map.events[event_id].character_name = graphic($1.to_i)
      $game_map.events[event_id].refresh
    end
    
  end
  
  alias update_graphic update
  def update
    update_graphic
    if @party != $game_party.actors && Auto_Update
      @party = $game_party.actors.clone
      $game_map.events.each_key {|i|
      graphic_check(i) if $game_map.events[i] != nil}
    end
  end
end

class Game_Event
  attr_accessor :character_name

  def set_graphic(character_name, character_hue, frame)
    @character_name = character_name
    @character_hue = character_hue
    change_pose(frame / 4, frame % 4)
  end

  def play_effect!(animation_id)
  	@animation_id = animation_id
  end

  def change_pose(dir, pattern)
  	@direction_fix = 0
    @direction = (dir + 1) * 2
    @original_direction = dir
    @pattern = pattern
    @original_pattern = pattern
  end
end
