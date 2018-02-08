# Map class holds and draws tiles and gems.
class Map
  attr_reader :width, :height, :gems

  def initialize(filename)
    # Load 60x60 tiles, 5px overlap in all four directions.
    @tileset = Gosu::Image.load_tiles("media/tileset.png", 60, 60, :tileable => true)

    gem_img = Gosu::Image.new("media/gem.png")
    @gems = []

    lines = File.readlines(filename).map { |line| line.chomp }
    @height = lines.size
    @width = lines[0].size
    @tiles = Array.new(@width) do |x|
      Array.new(@height) do |y|
        case lines[y][x, 1]
        when 'P'
          Tiles::Pierre
        when 'B'
          Tiles::Bronze
        when 'F'
          Tiles::Fert
        when 'O'
          Tiles::Or
        when 'D'
          Tiles::Diamand
        when 'R'
        Tiles::Ruby
        when '#'
          Tiles::Terre
        else
          nil
        end
      end
    end
  end

  def draw
    # Very primitive drawing function:
    # Draws all the tiles, some off-screen, some on-screen.
    @height.times do |y|
      @width.times do |x|
        tile = @tiles[x][y]
        if tile
          # Draw the tile with an offset (tile images have some overlap)
          # Scrolling is implemented here just as in the game objects.
          @tileset[tile].draw(x * 50 - 5, y * 50 - 5, 0)
        end
      end
    end
    @gems.each { |c| c.draw }
  end

  # Solid at a given pixel position?
  def solid?(x, y)
    y < 0 || @tiles[x / 50][y / 50]
  end
  
  def miner(x, y)
    puts y 
    case @tiles[x/50][y/50]
    when 0
      score = 10
    when 1
      score = 40
    when 2
      score = 5
    when 4
      score = 20
    when 5
      score = 100
    else
      score = 0
    end 
    @tiles[x/50][y/50] = nil
    return score
  end
end
