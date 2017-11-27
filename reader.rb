require "./body"
require "./simulation"

module Reader

    def Reader.read_simulation(filename)
        number_of_bodies, radius, bodies = 0, 0, []

        File.open("./simulations/#{filename}") do |f|
            f.each_line.with_index do |line, i|
                case i
                    when 0
                        number_of_bodies = line
                    when 1
                        radius = line
                    else
                        body_properties = line.split(" ")
                        bodies.push(Body.new(body_properties[0], body_properties[1], body_properties[2], body_properties[3], body_properties[4], body_properties[5]))
                end
            end
        end
        return Simulation.new(number_of_bodies, radius, bodies)
    end

end
