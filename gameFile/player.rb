# Player class.
class Player

  LifeLostPause = 1500
  attr_reader :x, :y, :score, :lives
  attr_accessor :score
  DistanceOfCollision = 35
  def initialize(map, x, y)
    @lives = 3
    @score = 0
    @sound_life_lost = Gosu::Sample.new("assets/sound/life-lost.wav")
    @x, @y = x, y
    @lost_life_at = -20_000
    @dir = :left
    @vy = 0 # Vertical velocity
    @map = map
    # Load all animation frames
    @standing, @walk1, @walk2, @standing2 = *Gosu::Image.load_tiles("media/spritesheet2.png", 50, 50)
    # This always points to the frame that is currently drawn.
    # This is set in update, and used in draw.
    @cur_image = @standing
  end

  def draw
    # Flip vertically when facing to the left.
    if @dir == :left
      offs_x = -25
      factor = 1.0
    else
      offs_x = 25
      factor = -1.0
    end
    @cur_image.draw(@x + offs_x, @y - 49, 0, factor, 1.0)
  end

  # Could the object be placed at x + offs_x/y + offs_y without being stuck?
  def would_fit(offs_x, offs_y)
    # Check at the center/top and center/bottom for map collisions
    not @map.solid?(@x + offs_x, @y + offs_y) and
      not @map.solid?(@x + offs_x, @y + offs_y - 45)
  end

  def update(move_x)
    # Select image depending on action
    if (move_x == 0)
      @cur_image = (Gosu.milliseconds / 175 % 2 == 0) ? @standing: @standing2
    else
      @cur_image = (Gosu.milliseconds / 175 % 2 == 0) ? @walk1 : @walk2
    end
    if (@vy < 0)
      @cur_image = @standing
    end

    # Directional walking, horizontal movement
    if move_x > 0
      @dir = :right
      move_x.times { if would_fit(1, 0) then @x += 1 end }
    end
    if move_x < 0
      @dir = :left
      (-move_x).times { if would_fit(-1, 0) then @x -= 1 end }
    end

    # Acceleration/gravity
    # By adding 1 each frame, and (ideally) adding vy to y, the player's
    # jumping curve will be the parabole we want it to be.
    @vy += 1
    # Vertical movement
    if @vy > 0
      @vy.times { if would_fit(0, 1) then @y += 1 else @vy = 0 end }
    end
    if @vy < 0
      (-@vy).times { if would_fit(0, -1) then @y -= 1 else @vy = 0 end }
    end
  end

  def try_to_jump
    if @map.solid?(@x, @y + 1)
      @vy = -20
    end
  end

  def collect_gems(gems)
    # Same as in the tutorial game.
    gems.reject! do |c|
      (c.x - @x).abs < 50 and (c.y - @y).abs < 50
    end
  end

  def just_lost_a_life?
    Gosu::milliseconds - @lost_life_at < LifeLostPause
  end

  def collect(items)
    items.reject! {|item| collide?(item) ? collision : false }
  end

  def collide?(item)
    distance = Gosu::distance(x_center_of_mass, y_center_of_mass,
                              item.x_center_of_mass, item.y_center_of_mass)
    distance < DistanceOfCollision
  end

  def x_center_of_mass
    @x + @cur_image.width / 2
  end

  def y_center_of_mass
    @y + @cur_image.height / 2
  end


  def collision()
    @lives -= 1
    @sound_life_lost.play(1.0)
    @lost_life_at = Gosu::milliseconds
    true
  end


end
