#The higher the number, the faster the simulation
SimulationSpeed = 25000

#Each planet or object
class Body

    attr_accessor :x, :y, :vx, :vy, :mass, :pic, :force, :g, :ax, :ay, :t

    def initialize(x, y, vx, vy, mass, pic)
    
        @x = x.to_f
        @y = y.to_f
        
        @vx = vx.to_f
        @vy = vy.to_f
        
        @mass = mass.to_f
        
        @pic = pic
        
        #X force and Y Force
        @force = [0.0, 0.0]
    
    end

    #Set the directional forces of the body
    def set_force(f)

        #Set X
        self.force[0] = f[0]
        
        #Set Y
        self.force[1] = f[1]

    end

    #Total force, not directional
    def calc_force(m1, m2, r)

        #Gravitational constant
        g = 6.67408 * (10 ** -11)

        return (g * m1 * m2) / (r ** 2)

    end

    #Convert the force to directional force, to be called once for x and once for y
    def calc_force_directional(f, d, r)

        return f * (d / r)
    
    end

    def calc_acceleration(f, m)

        return f / m

    end

    def calc_velocity(a, v0)

        return (a * SimulationSpeed) + v0

    end

    #This is the distance moved, not distance between two bodies
    def calc_distance(v0, v)

        return v0 + (v * SimulationSpeed)

    end

    #Simple distances (How far away up/down are they? Left/right?)
    def calc_how_far(b1,b2)

        #X distance
        dx = (b2.x - b1.x)
        
        #Y distance
        dy = (b2.y - b1.y)
        
        return [dx, dy]
    
    end

    #Simple pythagoran theorum
    def calc_length(b1, b2)

        #Get distances
        d = calc_how_far(b1,b2)

        return Math.sqrt(d[0] ** 2 + d[1] ** 2)
    
    end

    #Find the force of the body versus all other bodies
    def calc_total_force(bodies)

        f, fx, fy, dx, dy, r = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        
        #A loop to compare each body
        bodies.each do |body2|

            #Can't compare yourself or you'll get infinity
            next if body2 == self

            #The distance between the two bodies by straight line
            r = calc_length(self, body2)

            #Specific x and y distances
            dx = calc_how_far(self, body2)[0]
            dy = calc_how_far(self, body2)[1]

            #Calculate nondirectional force for the two bodies
            f = calc_force(mass, body2.mass, r)

            #Break it up into x and y forces
            fx += calc_force_directional(f, dx, r)
            fy += calc_force_directional(f, dy, r)

            #Reset the general force for the next body to compare, but not the directional forces
            f = 0.0

        end

        return [fx, fy]
    
    end

    #Called to draw each time
    def set_coords(bodies)

        #Get and set a new force
        set_force(calc_total_force(bodies))

        #Set out initial velocities so we can get the current velocities
        v0x = vx
        v0y = vy

        #X and Y acceleration
        ax = calc_acceleration(force[0], mass)
        ay = calc_acceleration(force[1], mass)

        #Set current velocities
        self.vx = calc_velocity(ax, v0x)
        self.vy = calc_velocity(ay, v0y)

        #Finally add the distances moved to their x and y to be drawn
        self.x += calc_distance(v0x, vx)
        self.y += calc_distance(v0y, vy)
        
    end

end
