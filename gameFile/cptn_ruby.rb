# Encoding: UTF-8

require 'rubygems'
require 'gosu'
require_relative "player"
require_relative "case"
require_relative "map"
require_relative "gems"
require_relative "cailloux"
require_relative "z_order"
require_relative "Map_creation"

WIDTH, HEIGHT = 640, 480

WindowWidth = 5000
WindowHeight = 10000

class CptnRuby < (Example rescue Gosu::Window)
  def initialize
    super WIDTH, HEIGHT

    self.caption = "Space Miner"

    @font = Gosu::Font.new(20, name: "assets/fonts/VT323/VT323-Regular.ttf")
    @fontvie = Gosu::Font.new(20, name: "assets/fonts/VT323/VT323-Regular.ttf")
    @fontGo = Gosu::Font.new(35, name: "assets/fonts/VT323/VT323-Regular.ttf")
    @song = Gosu::Song.new("assets/songs/Western-Music-Wild-Wild-West-Theme-Music-FREE-Royalty-free-Background-Music-Cowboy-Music.mp3")
    @song.volume = 0.25
    @song.play(true)
    @sound_pioche = Gosu::Sample.new("assets/sound/Bruit-pioche.wav")
    @sky = Gosu::Image.new("media/fondMine.png", :tileable => true)
    @map = Map.new("media/map.txt")
    @cptn = Player.new(@map, 400, 100)
    # The scrolling position is stored as top left corner of the screen.
    @camera_x = @camera_y = 0
    @items = []
    @game_over = false

  end

  def update
    return if @cptn.just_lost_a_life?
    return if @game_over
    @game_over = true if @cptn.lives <= 0
    move_x = 0
    move_x -= 5 if Gosu.button_down? Gosu::KB_LEFT
    move_x += 5 if Gosu.button_down? Gosu::KB_RIGHT
    @cptn.update(move_x)
    @cptn.collect_gems(@map.gems)
    # Scrolling follows player
    @camera_x = [[@cptn.x - WIDTH / 2, 0].max, @map.width * 50 - WIDTH].min
    @camera_y = [[@cptn.y - HEIGHT / 2, 0].max, @map.height * 50 - HEIGHT].min
    @cptn.collect(@items)

    update_items
    update_items
  end

  def draw
    if @game_over
      @fontGo.draw("GameOver ! your score is #{@cptn.score}", 100, 140, 4, 1.0, 1.0,
      0xff_ffffff)
      @fontGo.draw("Your score is #{@cptn.score}", 100, 200, 4, 1.0, 1.0,
      0xff_ffffff)
      @fontGo.draw("Press space to play again", 100, 260, 4, 1.0, 1.0,
      0xff_ffffff)
    end 
    @sky.draw 0, 0, 0
    @font.draw("Score : #{@cptn.score}", 0, 0, 10, 1.0, 1.0,
    0xff_ffffff)
    @fontvie.draw("Vie : #{@cptn.lives}", 0, 20, 10, 1.0, 1.0,
    0xff_ffffff)
    Gosu.translate(-@camera_x, -@camera_y) do
      @map.draw
      @items.each(&:draw)
      @cptn.draw
      @items.reject! {|item| item.y > WindowHeight }
    end
  end

  def button_down(id)
    case id
    when Gosu::KB_UP
      @cptn.try_to_jump
    when Gosu::KB_W
      @sound_pioche.play(0.1)
      @cptn.score += @map.miner(@cptn.x, @cptn.y - 50)
    when Gosu::KB_S
      @sound_pioche.play(0.1)
      @cptn.score += @map.miner(@cptn.x, @cptn.y + 45)
    when Gosu::KB_A
      @sound_pioche.play(0.1)
      @cptn.score += @map.miner(@cptn.x - 50, @cptn.y)
    when Gosu::KB_D
      @sound_pioche.play(0.1)
      @cptn.score += @map.miner(@cptn.x + 45, @cptn.y)
    when Gosu::KB_SPACE
      if @game_over
        Map_creation.new
        CptnRuby.new.show
      end
    when Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end

def update_items
  unless @items.size >= @cptn.score + 100
    (1..10).each do
      r = rand
      if r < 0.035
        @items.push(Cailloux.new(:cailloux1))
      elsif r < 0.040
        @items.push(Cailloux.new(:cailloux2))
      end
    end
  end
  @items.each(&:update)
  @items.reject! {|item| item.y > WindowHeight }
end

def update_player
  @player.go_left if Gosu::button_down?(Gosu::KbLeft)
  @player.go_right if Gosu::button_down?(Gosu::KbRight)
  @player.move
end


CptnRuby.new.show if __FILE__ == $0
