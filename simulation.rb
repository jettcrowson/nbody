class Simulation

    attr_reader :number_of_bodies, :radius, :bodies

    def initialize(number_of_bodies, radius, bodies)
        @number_of_bodies = number_of_bodies
        @radius = radius
        @bodies = bodies
    end

end
