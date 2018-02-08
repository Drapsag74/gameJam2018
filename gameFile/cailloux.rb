class Cailloux
    attr_reader :x, :y
  
    def initialize(type)
        @type = type
      @image = if type == :cailloux1
                 Gosu::Image.new("images/cailloux1.png")
               elsif type == :cailloux2
                 Gosu::Image.new("images/cailloux2.png")
               end
  
      @velocity = Gosu::random(0.8, 3.3)
  
      @x = rand * (WindowWidth - @image.width)
      @y = 0
    end
  
    def update
      @y += @velocity
    end
  
    def draw
      @image.draw(@x, @y, ZOrder::Items)
    end

    def x_center_of_mass
        @x + @image.width / 2
    end
    
    def y_center_of_mass
        @y
    end
    
  
  end
  