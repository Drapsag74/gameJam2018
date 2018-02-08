class Window < Gosu::Window

  def initialize(width, height)
    super
    self.caption = "Mon jeu"
    # 1er attribut image qui prend le fichier picture.jpg placé dans le répertoire res
    @background_image = Gosu::Image.new("res/picture.jpg")
    # 2e attribut image qui prend le fichier hero.png placé dans le répertoire res
    @hero_image = Gosu::Image.new("res/hero.png")
  end

  # la méthode draw de la classe Window est appelée 60 fois ou moins par seconde
  def draw
    # la méthode draw prend 3 paramètres :
    # - abcisse
    # - ordonnée
    # - profondeur
    @background_image.draw(0, 0, 0)
    @hero_image.draw(width/2, height/2, 1)
    # l'image du héros est affichée au dessus de celle du fond (1>0)
  end

end
