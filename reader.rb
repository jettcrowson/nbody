require "./body"
require "./simulation"

module Reader

    def Reader.read_simulation(filename)

        number_of_bodies, radius, bodies = 0, 0, []

        #Open the simulation file
        File.open("./simulations/#{filename}") do |f|

            #Read the file line by line
            f.each_line.with_index do |line, i|
                
                #Skip blank lines
                if line == "\n" then next end

                #Since we only need special action on the first and second lines we can specify that and use the else property to read n number or bodies
                case i

                    #First line is always the number of bodies
                    when 0

                        number_of_bodies = line
                    
                    #Second line is always the radius
                    when 1

                        radius = line
                    else

                        #Strip all the whitespace to just leave a value for each element
                        body_properties = line.gsub(/\s+/m, ' ').strip.split(" ")

                        #Skip if blank
                        if body_properties[0] == nil then next end
                        
                        #End if it goes to the credits
                        if body_properties[0] == "Creator" then break end
                        if body_properties[0] == "//" then break end

                        #Create a new body with all the properties from the split line
                        bodies.push(Body.new(body_properties[0], body_properties[1], body_properties[2], body_properties[3], body_properties[4], body_properties[5]))

                end

            end

        end

        #Return a simulation with the list of bodies
        return Simulation.new(number_of_bodies, radius, bodies)
    
    end

end
