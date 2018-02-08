# inclure la librairie graphique gosu
require 'gosu'

# inclure le fichier window.rb
require_relative 'window'

# variables largeur et hauteur de la fenêtre
WindowWidth = 1024
WindowHeight = 576

# instanciation d'un objet de la classe Window
Window = Window.new(WindowWidth, WindowHeight)
# affichage de la fenêtre
Window.show
