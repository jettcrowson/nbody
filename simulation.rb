require "gosu"
require_relative "z_order"

class Simulation

    attr_reader :number_of_bodies, :radius, :bodies

    def initialize(number_of_bodies, radius, bodies)
        @number_of_bodies = number_of_bodies.to_i
        @radius = radius.to_f
        @bodies = bodies

        bodies[0].calc_force(bodies)
        puts "Force: #{bodies[0].force}"
        # bodies[0].set_force(calculate_body_force(bodies[0]))
        # puts "Acc: #{calculate_body_acceleration(bodies[0])}"
    end

    def convert_coords(x, y, img)
        return [((320 * x) / radius) + 320 - (img.width / 2),
                ((320 * y) / radius) + 320 - (img.height / 2)]
    end

    def draw
        bodies.each do |body|
            body_image = Gosu::Image.new("images/#{body.pic}")
            coords = convert_coords(body.x, body.y, body_image)
            body_image.draw(coords[0], coords[1], ZOrder::Body)
        end
    end


end
