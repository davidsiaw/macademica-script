
class CharacterHideService
  def hide
    $character_hidden = true
    p "hide character"
  end
  
  def show
    $character_hidden = false
    p "show character"
  end
end
