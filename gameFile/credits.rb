# Encoding: UTF-8

require 'rubygems'
require 'gosu'

WIDTH, HEIGHT = 640, 480

class Credits < (Example rescue Gosu::Window)
  PADDING = 20
  
  def initialize
    super WIDTH, HEIGHT
    
    self.caption = "Crédits"
    
    text =
      "<b> Space Miner </b>
      Gaspard Anthoine - Développeur 
      Fabien Carrier - Développeur 
      Obride Deki - Designer/Développeur 
      Eddy Sarrasin - Graphiste/Monteur vidéo
      "
    
    # Remove all leading spaces so the text is left-aligned
    text.gsub! /^ +/, ''
    
    @text = Gosu::Image.from_text text, 20, :width => WIDTH - 2 * PADDING
    
    @background = Gosu::Image.new "media/space.png"
  end
  
  def draw
    draw_rotating_star_backgrounds
    
    @text.draw PADDING, PADDING, 0
  end
  
  def draw_rotating_star_backgrounds
    # Disregard the math in this method, it doesn't look as good as I thought it
    # would. =(
    
    angle = Gosu.milliseconds / 50.0
    scale = (Gosu.milliseconds % 1000) / 1000.0
    
    [1, 0].each do |extra_scale|
      @background.draw_rot WIDTH * 0.5, HEIGHT * 0.75, 0, angle, 0.5, 0.5,
        scale + extra_scale, scale + extra_scale
    end
  end
end

Credits.new.show if __FILE__ == $0
