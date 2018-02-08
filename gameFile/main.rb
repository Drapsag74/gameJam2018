require 'gosu'
require_relative 'menu.rb'
require_relative 'menuitem.rb'
require_relative 'cptn_ruby'
require_relative 'credits'
require_relative 'Map_creation'
require_relative 'commandes'

class Main < Gosu::Window
	def initialize
		super(700, 703, false)
		@cursor = Gosu::Image.new(self, "images/cursor.png", false)
		x = self.width / 2 - 100
		y = self.height  / 2 - 100
		lineHeight = 50
		self.caption = "Space Miner"
		items = Array["lancerPartie", "credits", "commandes", "quitter"]
		actions = Array[lambda { 
			Map_creation.new
			CptnRuby.new.show }, lambda {Credits.new.show}, lambda {Commandes.new.show}, lambda { self.close }]
		@menu = Menu.new(self)
		for i in (0..items.size - 1)
			@menu.add_item(Gosu::Image.new(self, "images/#{items[i]}.png", false), x, y, 1, actions[i], Gosu::Image.new(self, "images/#{items[i]}_hover.png", false))
			y += lineHeight
		end
		@back = Gosu::Image.new(self, "images/back.png", false)
	end

	def update
		@menu.update
	end

	def draw
		@cursor.draw(self.mouse_x, self.mouse_y, 2)
		@back.draw(0,0,0)
		@menu.draw
	end

	def button_down (id)
		if id == Gosu::MsLeft then
			@menu.clicked
		end
	end

end

Main.new.show
