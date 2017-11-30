require "gosu"
require_relative "z_order"

class Simulation

    attr_reader :number_of_bodies, :radius, :bodies, :g

    def initialize(number_of_bodies, radius, bodies)
        @number_of_bodies = number_of_bodies.to_i
        @radius = radius.to_f
        @bodies = bodies
        @g = 6.67408 * (10 ** -11)

        puts calculate_body_force(bodies[0])
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

    def calculate_body_force(body1)
        force, fx, fy, dx, dy, r = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

        bodies.each do |body2|
            next if body2 == body1
            m1 = body1.mass
            m2 = body2.mass
            dx = (body1.x - body2.x).abs
            dy = (body1.y - body2.y).abs
            r = Math.sqrt(dx ** 2 + dy ** 2)
            force += (g * m1 * m2) / (r ** 2)
        end
        
        fx = force * (dx / r)
        fy = force * (dy / r)

        return [fx, fy]
    end

end
