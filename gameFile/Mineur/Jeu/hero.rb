require 'gosu'
require_relative 'animation'

class Hero

  def initialize(x, y)

    # création d'un tableau qui contiendra les différentes images du héros
      @framesG = []
      @framesD = []

    # on ajoute les 19 images dans le tableau
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0001.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0002.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0003.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0004.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0005.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0006.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0007.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0008.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0009.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0010.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0011.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0012.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0013.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0014.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0015.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0016.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0017.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0018.png"))
    @framesG.push(Gosu::Image.new("res/hero/spriteG/sprite0019.png"))

    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0001.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0002.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0003.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0004.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0005.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0006.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0007.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0008.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0009.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0010.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0011.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0012.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0013.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0014.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0015.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0016.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0017.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0018.png"))
    @framesD.push(Gosu::Image.new("res/hero/spriteD/sprite0019.png"))


    # @images.push(Gosu::Image.new("res/hero/face.png"))
    # @images.push(Gosu::Image.new("res/hero/dos.png"))
    # @images.push(Gosu::Image.new("res/hero/gauche.png"))
    # @images.push(Gosu::Image.new("res/hero/droite.png"))
    # @images.push(Gosu::Image.new("res/hero/taper.png"))
    # @images.push(Gosu::Image.new("res/hero/tapergauche.png"))
    # @images.push(Gosu::Image.new("res/hero/taperdroite.png"))
    # @images.push(Gosu::Image.new("res/hero/taperbas.png"))
    # # de base, le héros est de face
    # @image = @images[0]

    @x, @y = x, y
    @vy = 0 # Vertical velocity
@move = {:left => Animation.new(@framesG[1..20], 0.04),
         :right => Animation.new(@framesD[1..20], 0.04),
         :up => Animation.new(@framesD[1..20], 0.04 )}

@movementsX = {:left => -2.0, :right => 2.0, :up=> 0.0}
@movementsY = {:left => 0.0, :right => 0.0,:up => -2.0}

@moving = false
@facing = :left
  end

  def draw
    if @moving
      @move[@facing].start.draw @x, @y, 1
    else
      @move[@facing].stop.draw @x, @y, 1
    end
  end

  def move(direction)
    @x += @movementsX[direction]
    @x %= 640

    @y += @movementsY[direction]
    @y %= 640

    @facing = direction
    @moving = true if @moving != true
  end

  def stop_move
    @moving = false if @moving != false
  end
end


  # def draw
  #   @image.draw(@x, @y, ZOrder::Hero)
  # end
  #
  # def go_left
  #   @velocityX -= 0.1
  #   # changement de l'image du héros : tourné vers la gauche
  #
  #   @image = @images[2]
  #   sleep 0.01
  #
  # end
  #
  # def go_right
  #   @velocityX += 0.4
  #   # changement de l'image du héros : tourné vers la droite
  #   @image = @images[3]
  # end
  #
  # def go_up
  #   @velocityY -= 0.4
  #   # changement de l'image du héros : tourné vers le haut
  #   @image = @images[1]
  # end
  #
  # def go_down
  #   @velocityY += 0.4
  #   # changement de l'image du héros : tourné vers le bas
  #   @image = @images[0]
  # end
  #
  # def taper
  #   @image = @images[4]
  # end
  #
  # def taperGauche
  #   @image = @images[5]
  # end
  #
  # def taperDroite
  #   @image = @images[6]
  # end
  #
  # def taperBas
  #   @image = @images[7]
  # end
  #
  # def move
  #   @x += @velocityX
  #   @x %= 1024
  #   @y += @velocityY
  #   @y %= 576
  #   @velocityX *= 0.96
  #   @velocityY *= 0.96
  # end
