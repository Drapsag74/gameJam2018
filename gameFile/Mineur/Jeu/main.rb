require 'gosu'
require_relative 'hero'
require_relative 'z_order'
require_relative 'window'


class GameWindow < Gosu::Window
  def initialize
    super 1500, 1000
    self.caption = "TestMouvement"

    @hero = Hero.new 200,200

    @key = {kb_left: Gosu::KbLeft,
            kb_right: Gosu::KbRight,
            gp_left: Gosu::GpLeft,
            gp_right: Gosu::GpRight,
            kb_up: Gosu::KbUp,
            kb_escape: Gosu::KbEscape}
  end

  def update
    if Gosu::button_down? @key[:kb_left]
      @hero.move :left
    end
    if Gosu::button_down? @key[:kb_right]
      @hero.move :right
    end
    if Gosu::button_down? @key[:kb_up]
      @hero.move :up
    end
    if Gosu::button_down? @key[:kb_escape]
      close
    end
  end

  def draw
    @hero.draw
  end

  def button_up(id)
    if id == @key[:kb_left] or id == @key[:gp_left] then
      @hero.stop_move
    end
    if id == @key[:kb_right] or id == @key[:gp_right] then
      @hero.stop_move
    end
    if id == @key[:kb_up] then
      @hero.stop_move
    end
  end




end

GameWindow.new.show
