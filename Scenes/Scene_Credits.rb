class Scene_Credits

# This next piece of code is the credits.
CREDIT=<<_END_



Macademica

Produced by astrobunny

____________________________________________________










- SCRIPTS -

[Console output]
ForeverZer0

[Script Command Messages]
ForeverZer0

[Scene_Credits]
Emily_Konichi
AvatarMonkeyKirby
HellfireDragon
Dweller

[Event Graphic Changer]
nathmatt
____________________________________________________






- TESTING -

KuroMocha
eyalmazuz
____________________________________________________






- ART & SPRITING -

[Tileset]
Lmnopguy7

[Item Icons]
Candy Coded Response
____________________________________________________












- SPECIAL THANKS -

eyalmazuz
for the fun conversation that spawned this game
____________________________________________________




Made with RPG Maker XP

_END_

  CREDITS_FONT = ""
  CREDITS_SIZE = 12
  CREDITS_OUTLINE = Color.new(12, 12, 12, 255)
  CREDITS_SHADOW = Color.new(0, 0, 0, 255)
  CREDITS_FILL = Color.new(255, 255, 255, 255)
  
  def main
    #-------------------------------
    # Animated Background Setup
    #-------------------------------
    
    @sprite = Sprite.new
    #@sprite.bitmap = RPG::Cache.title($data_system.title_name)
    #Edit this to the title screen(s) you wish to show in the background.
    # They do repeat.
    @backgroundList = ["001-Title01"] 
    @backgroundGameFrameCount = 0
    # Number of game frames per background frame.
    @backgroundG_BFrameCount = 3.4
    @sprite.bitmap = RPG::Cache.title(@backgroundList[0])
    
    #------------------
    # Credits txt Setup
    #------------------
    
    credit_lines = CREDIT.split(/\n/)
    credit_bitmap = Bitmap.new(640,32 * credit_lines.size)
    credit_lines.each_index do |i|
      line = credit_lines[i]
      x = 0
      credit_bitmap.font.color = CREDITS_OUTLINE
      credit_bitmap.draw_text(0 + 1,i * 32 + 1,640,32,line,1)
      credit_bitmap.draw_text(0 - 1,i * 32 + 1,640,32,line,1)
      credit_bitmap.draw_text(0 + 1,i * 32 - 1,640,32,line,1)
      credit_bitmap.draw_text(0 - 1,i * 32 - 1,640,32,line,1)
      credit_bitmap.font.color = CREDITS_SHADOW
      credit_bitmap.draw_text(0,i * 32 + 8,640,32,line,1)
      credit_bitmap.font.color = CREDITS_FILL
      credit_bitmap.draw_text(0,i * 32,640,32,line,1)
    end
    @credit_sprite = Sprite.new(Viewport.new(0,50,640,380))
    @credit_sprite.bitmap = credit_bitmap
    @credit_sprite.z = 9998
    @credit_sprite.oy = -430 #-430
    @frame_index = 0
    @last_flag = false
    
    #--------
    # Setup
    #--------
    
    #Stops all audio but background music.
    Audio.me_stop
    Audio.bgs_stop
    Audio.se_stop
    
    Graphics.transition
    
    loop do
      Graphics.update
      Input.update
      update
      if $scene != self
        break
      end
    end
      
    Graphics.freeze
    @sprite.dispose
    @credit_sprite.dispose
  end
  
  ##Checks if credits bitmap has reached it's ending point
  def last?
    if @frame_index > (@credit_sprite.bitmap.height + 500)
      return true
    end
    return false
  end

  #Check if the credits should be cancelled
  def cancel?
    if Input.trigger?(Input::C)
      return true
    end
    return false
  end
  
  def cleanup!
    $scene = Scene_Title.new
    Audio.bgm_fade(1000)
    Audio.bgm_stop
  end
      
  def update
    @backgroundGameFrameCount = @backgroundGameFrameCount + 1
    if @backgroundGameFrameCount >= @backgroundG_BFrameCount
      @backgroundGameFrameCount = 0
      # Add current background frame to the end
      @backgroundList = @backgroundList << @backgroundList[0]
      # and drop it from the first position
      @backgroundList.delete_at(0)
      @sprite.bitmap = RPG::Cache.title(@backgroundList[0])
    end
    if cancel? || last?
      cleanup!
    end
    @credit_sprite.oy += 1 #this is the speed that the text scrolls. 1 is default
    #The fastest I'd recomend is 5, after that it gets hard to read.
    @frame_index += 1 #This should fix the non-self-ending credits
  end
end
