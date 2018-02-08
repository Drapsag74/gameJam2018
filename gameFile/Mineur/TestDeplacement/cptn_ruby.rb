# Encoding: UTF-8

# Basically, the tutorial game taken to a jump'n'run perspective.

# Shows how to
#  * implement jumping/gravity
#  * implement scrolling using Window#translate
#  * implement a simple tile-based map
#  * load levels from primitive text files

# Some exercises, starting at the real basics:
#  0) understand the existing code!
# As shown in the tutorial:
#  1) change it use Gosu's Z-ordering
#  2) add gamepad support
#  3) add a score as in the tutorial game
#  4) similarly, add sound effects for various events
# Exploring this game's code and Gosu:
#  5) make the player wider, so he doesn't fall off edges as easily
#  6) add background music (check if playing in Window#update to implement
#     looping)
#  7) implement parallax scrolling for the star background!
# Getting tricky:
#  8) optimize Map#draw so only tiles on screen are drawn (needs modulo, a pen
#     and paper to figure out)
#  9) add loading of next level when all gems are collected
# ...Enemies, a more sophisticated object system, weapons, title and credits
# screens...

require 'rubygems'
require 'gosu'
require_relative "player"
require_relative "case"
require_relative "map"
require_relative "gems"

WIDTH, HEIGHT = 640, 480

class CptnRuby < (Example rescue Gosu::Window)
  def initialize
    super WIDTH, HEIGHT

    self.caption = "Cptn. Ruby"

    @sky = Gosu::Image.new("media/space.png", :tileable => true)
    @map = Map.new("media/map.txt")
    @cptn = Player.new(@map, 400, 100)
    # The scrolling position is stored as top left corner of the screen.
    @camera_x = @camera_y = 0
  end

  def update
    move_x = 0
    move_x -= 5 if Gosu.button_down? Gosu::KB_LEFT
    move_x += 5 if Gosu.button_down? Gosu::KB_RIGHT
    @cptn.update(move_x)
    @cptn.collect_gems(@map.gems)
    # Scrolling follows player
    @camera_x = [[@cptn.x - WIDTH / 2, 0].max, @map.width * 50 - WIDTH].min
    @camera_y = [[@cptn.y - HEIGHT / 2, 0].max, @map.height * 50 - HEIGHT].min
  end

  def draw
    @sky.draw 0, 0, 0
    Gosu.translate(-@camera_x, -@camera_y) do
      @map.draw
      @cptn.draw
    end
  end

  def button_down(id)
    case id
    when Gosu::KB_UP
      @cptn.try_to_jump
    when Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end

CptnRuby.new.show if __FILE__ == $0
