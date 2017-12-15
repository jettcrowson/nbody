require "gosu"
require_relative "z_order"

#Created by the reader
class Simulation

    attr_reader :number_of_bodies, :radius, :bodies

    def initialize(number_of_bodies, radius, bodies)

        @number_of_bodies = number_of_bodies.to_i

        @radius = radius.to_f

        @bodies = bodies

    end

    #Scale down the universe scale to fit on the screen
    def convert_coords(x, y, img)
        
        return [((320 * x) / radius) + 320 - (img.width / 2),
                ((320 * y) / radius) + 320 - (img.height / 2)]
    
    end

    def update

        bodies.each do |body|

            #Each time update is called we need to update the coordinates according to body forces
            body.set_coords(bodies)

        end

    end

    def draw

        #Draw each body
        bodies.each do |body|
            
            #Set the image
            body_image = Gosu::Image.new("images/#{body.pic}")
            
            #Converted the coords, but invert the y due to gosus inverted y
            coords = convert_coords(body.x, -body.y, body_image)
            
            #Finally draw with the scaled down coords
            body_image.draw(coords[0], coords[1], ZOrder::Body)

        end

    end


end
