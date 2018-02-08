# classe fille Window qui hérite de la classe Window de Gosu
class Window < Gosu::Window

  # constructeur de la classe Window
  def initialize(width, height)
    # appel au constructeur de la classe Gosu::Window
    super
    # nom de la fenetre
    self.caption = "Mon jeu"
  end

end
