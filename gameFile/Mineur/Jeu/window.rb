class Window < Gosu::Window

  def initialize(width, height)
    super
    self.caption = "Mon jeu"
    @background_image = Gosu::Image.new("res/decor.png")
    @hero = Hero.new(width/2, height/2)
    # @song = Gosu::Song.new("res/music.mp3")
    # @song.volume = 0.25
    # @song.play(true)
  end

  def update

    #Déplacements de base
    @hero.go_left if Gosu::button_down?(Gosu::KbLeft)
    @hero.go_right if Gosu::button_down?(Gosu::KbRight)
    @hero.go_up if Gosu::button_down?(Gosu::KbUp)
    @hero.go_down if Gosu::button_down?(Gosu::KbDown)

    #Minage selon direction et attaque
    @hero.taper if Gosu::button_down?(Gosu::KbSpace)

    if (Gosu::button_down?(Gosu::KbSpace) && Gosu::button_down?(Gosu::KbLeft))
      @hero.taperGauche
    end

    if (Gosu::button_down?(Gosu::KbSpace) && Gosu::button_down?(Gosu::KbRight))
      @hero.taperDroite
    end

    if (Gosu::button_down?(Gosu::KbSpace) && Gosu::button_down?(Gosu::KbDown))
      @hero.taperBas
    end


    @hero.move
    close if Gosu::button_down?(Gosu::KbEscape)
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @hero.draw
  end

end
