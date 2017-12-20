require "gosu"
require "body.rb"
require_relative "z_order"

#Created by the reader
class Simulation

    attr_reader :number_of_bodies, :radius, :bodies

    def initialize(number_of_bodies, radius, bodies)

        @number_of_bodies = number_of_bodies.to_i

        @radius = radius.to_f

        @bodies = bodies

        bodies.each do |body|

            #should scale the initial radius to be a ratio of img size to screen size and universe radius
            body.radius = (pic.width * 2 * radius) / 320
            
        end

    end

    #Scale down the universe scale to fit on the screen
    def convert_coords(x, y, z, img)
        
        return [((320 * x) / radius) + 320 - (img.width / 2),
                ((320 * y) / radius) + 320 - (img.height / 2),
                ((320 * z) / radius)]
    
    end

    def update

        bodies.each do |body|

            #Each time update is called we need to update the coordinates according to body forces
            body.set_coords(bodies)

        end

        check_collisions

    end

    def check_collisions()

        bodies.each do |body|

            bodies.each do |body2|

                if body == body2 then next end

                #if it is colliding in all 3 directions
                if body.x > body2.x && (body.x +  2 * body2.radius) < (body2.x +  2 * body2.radius) && body.y > body2.y && (body.y +  2 * body2.radius) < (body2.y +  2 * body2.radius) && body.z > body2.z && (body.z +  2 * body2.radius) < (body2.z +  2 * body2.radius)
                    break_body(body)
                    break_body(body2)
                end

            end
            
        end

    end

    def break_body(body)
        bodies.delete(body)

        b1 = Body.new(body.x, body.y, body.vx, body.vy, body.mass / 2, body.pic)
        b1.scale *= 0.5
        b1.vx = Math.rand(-1..1)
        b1.vy = Math.rand(-1..1)
        b1.vz = Math.rand(-1..1)

        b2 = Body.new(body.x, body.y, body.vx, body.vy, body.mass / 2, body.pic)
        b2.scale *= 0.5
        b2.vx = Math.rand(-1..1)
        b2.vy = Math.rand(-1..1)
        b2.vz = Math.rand(-1..1)

        bodies.push(b1)
        bodies.push(b2)
    end

    def draw

        #Draw each body
        bodies.each_with_index do |body, i|

            puts "Body #{i + 1} position: x: #{body.x} | y: #{body.y} | z: #{body.z} | x vel: #{body.vx} | y vel: #{body.vy} | z vel: #{body.vz}"

            #Skip if its out of the z radius
            if body.z.abs > radius then next end
            
            #Set the image
            body_image = Gosu::Image.new("images/#{body.pic}")
            
            #Converted the coords, but invert the y due to gosus inverted y
            coords = convert_coords(body.x, -body.y, body.z body_image)

            #how far in the z range is it
            scale_percent = (body.z / radius)

            #Body scale used for when the bodies split and are half size
            scale = body.scale

            if scale_percent > 0
                #If the z is positive
                scale = scale * scale_percent * 5
            else
                #If negative
                scale = scale * scale_percent * 0.2
            end
            
            #Finally draw with the scaled down coords
            body_image.draw(coords[0], coords[1], convert_coords[2], scale)

        end

    end


end
