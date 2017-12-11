require "gosu"
require "./reader"

require_relative "z_order"

class NbodySimulation < Gosu::Window

  def initialize
    super(640, 640, false)
    self.caption = "NBody simulation"
    planet = ARGV
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    @simulation = Reader.read_simulation("#{planet[0]}.txt")
  end

  def update
    @simulation.update
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @simulation.draw
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
  
end

window = NbodySimulation.new
window.show