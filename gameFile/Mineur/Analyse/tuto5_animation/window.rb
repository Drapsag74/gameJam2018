class Window < Gosu::Window

  def initialize(width, height)
    super
    self.caption = "Mon jeu"
    @background_image = Gosu::Image.new("res/picture.jpg")
    @hero = Hero.new(width/2, height/2)
    @song = Gosu::Song.new("res/music.mp3")
    @song.volume = 0.25
    @song.play(true)
  end

  def update
    @hero.go_left if Gosu::button_down?(Gosu::KbLeft)
    @hero.go_right if Gosu::button_down?(Gosu::KbRight)
    @hero.go_up if Gosu::button_down?(Gosu::KbUp)
    @hero.go_down if Gosu::button_down?(Gosu::KbDown)
    @hero.move
    close if Gosu::button_down?(Gosu::KbEscape)
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @hero.draw
  end

end
