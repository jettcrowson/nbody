require "./body"
require "./simulation"

module Reader

    def Reader.read_simulation(filename)

        number_of_bodies, radius, bodies = 0, 0, []

        #Open the simulation file
        File.open("./simulations/#{filename}") do |f|

            #Read the file line by line
            f.each_line.with_index do |line, i|

                #Since we only need special action on the first and second lines we can specify that and use the else property to read n number or bodies
                case i
                    when 0
                        number_of_bodies = line
                    when 1
                        radius = line
                    else
                        body_properties = line.gsub(/\s+/m, ' ').strip.split(" ")

                        if body_properties[0] == nil then next end
                        if body_properties[0] == "Creator" then break end

                        bodies.push(Body.new(body_properties[0], body_properties[1], body_properties[2], body_properties[3], body_properties[4], body_properties[5]))
                end
            end
        end
        return Simulation.new(number_of_bodies, radius, bodies)
    end

end
