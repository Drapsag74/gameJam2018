require 'gosu'

class Window < Gosu::Window

  def initialize(width, height)
    super
    self.caption = "Mon jeu"
    @background_image = Gosu::Image.new("res/picture.jpg")
    @hero_image = Gosu::Image.new("res/hero.png")
    # attribut musique qui prend le fichier music.mp3 dans le répertoire res
    @song = Gosu::Song.new("res/music.mp3")
    # fixe le volume à 0.25
    @song.volume = 0.25
    # lance la musique
    @song.play(true)
  end

  def draw
    @background_image.draw(0, 0, 0)
    @hero_image.draw(width/2, height/2, 1)
  end

end
