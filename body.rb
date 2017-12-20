#The higher the number, the faster the simulation
SimulationSpeed = 25000

#Each planet or object
class Body

    attr_accessor :x, :y, :z, :vx, :vy, :vz, :mass, :pic, :force, :g, :ax, :ay, :t, :radius, :scale

    def initialize(x, y, vx, vy, mass, pic)
    
        @x = x.to_f
        @y = y.to_f
        
        #Starts at 0 because we are not given a starting z
        @z = 0
        
        @vx = vx.to_f
        @vy = vy.to_f

        #We are not given a starting z velocity
        @vz = 0
        
        @mass = mass.to_f
        
        @pic = pic
        
        #X force and Y Force and Z force
        @force = [0.0, 0.0, 0.0]
        
        #Radius is set in simulation, calculated by the image width to the screen width
        @radius = 0.0

        @scale = 1
    
    end

    #Set the directional forces of the body
    def set_force(f)

        #Set X
        self.force[0] = f[0]
        
        #Set Y
        self.force[1] = f[1]

        #Set Z
        self.force[2] = f[2]

    end

    #Total force, not directional
    #After further research, stays the same, regardless of z
    def calc_force(m1, m2, r)

        #Gravitational constant
        g = 6.67408 * (10 ** -11)

        return (g * m1 * m2) / (r ** 2)

    end

    #Convert the force to directional force, to be called once for x and once for y
    #Can actually just call this a third time for Z
    def calc_force_directional(f, d, r)

        return f * (d / r)
    
    end

    #Apparently does not have to be changed, just called again for the z direction
    def calc_acceleration(f, m)

        return f / m

    end

    #Again, does not have to be changed
    def calc_velocity(a, v0)

        return (a * SimulationSpeed) + v0

    end

    #This is the distance moved, not distance between two bodies
    def calc_distance(v0, v)

        return v0 + (v * SimulationSpeed)

    end

    #Simple distances (How far away up/down are they? Left/right?)
    #Adapt for Z
    def calc_how_far(b1,b2)

        #X distance
        dx = (b2.x - b1.x)
        
        #Y distance
        dy = (b2.y - b1.y)

        #Z distance
        dz = (b2.z - b1.z)
        
        return [dx, dy, dz]
    
    end

    #Simple pythagoran theorum
    #adapt for z
    def calc_length(b1, b2)

        #Get distances
        d = calc_how_far(b1,b2)

        xy_length = Math.sqrt(d[0] ** 2 + d[1] ** 2)

        total_length = Math.sqrt(xy_length ** 2 + d[2] ** 2)

        return total_length
    
    end

    #Find the force of the body versus all other bodies
    def calc_total_force(bodies)

        f, fx, fy, dx, dy, dz, r = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        
        #A loop to compare each body
        bodies.each do |body2|

            #Can't compare yourself or you'll get infinity
            next if body2 == self

            #The distance between the two bodies by straight line
            r = calc_length(self, body2)

            #Specific x, y, and z distances
            dx = calc_how_far(self, body2)[0]
            dy = calc_how_far(self, body2)[1]
            dz = calc_how_far(self, body2)[2]

            #Calculate nondirectional force for the two bodies
            f = calc_force(mass, body2.mass, r)

            #Break it up into x and y forces
            fx += calc_force_directional(f, dx, r)
            fy += calc_force_directional(f, dy, r)
            fz += calc_force_directional(f, dz, r)

            #Reset the general force for the next body to compare, but not the directional forces
            f = 0.0

        end

        return [fx, fy, fz]
    
    end

    #Called to draw each time
    def set_coords(bodies)

        #Get and set a new force
        set_force(calc_total_force(bodies))

        #Set out initial velocities so we can get the current velocities
        v0x = vx
        v0y = vy
        v0z = vz

        #X and Y acceleration
        ax = calc_acceleration(force[0], mass)
        ay = calc_acceleration(force[1], mass)
        az = calc_acceleration(force[2], mass)

        #Set current velocities
        self.vx = calc_velocity(ax, v0x)
        self.vy = calc_velocity(ay, v0y)
        self.vy = calc_velocity(az, v0z)

        #Finally add the distances moved to their x and y to be drawn
        self.x += calc_distance(v0x, vx)
        self.y += calc_distance(v0y, vy)
        self.z += calc_distance(v0z, vz)
        
    end

end
