class Body

    attr_accessor :x, :y, :vx, :vy, :mass, :pic, :force, :g, :ax, :ay, :t

    def initialize(x, y, vx, vy, mass, pic)
        @x = x.to_f
        @y = y.to_f
        @vx = vx.to_f
        @vy = vy.to_f
        @mass = mass.to_f
        @pic = pic
        @force = [0.0, 0.0]
        @ax = 0.0
        @ay = 0.0

        @t = 25000
        @g = 6.67408 * (10 ** -11)
    end

    def set_force(f)
        self.force[0] = f[0]
        self.force[1] = f[1]
    end

    def calc_force(bodies)
        f, fx, fy, dx, dy, r = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        
        bodies.each do |body2|
            next if body2 == self
            m1 = mass
            m2 = body2.mass
            dx = (x - body2.x).abs
            dy = (y - body2.y).abs
            r = Math.sqrt(dx ** 2 + dy ** 2)
            f += (g * m1 * m2) / (r ** 2)
        end
        
        fx = f * (dx / r)
        fy = f * (dy / r)

        return [fx, fy]
    end

    def calc_acc
        temp_ax = force[0] / mass
        temp_ay = force[1] / mass

        return [temp_ax, temp_ay]
    end

    def calc_vel
        temp_vx = (ax * t) + vx
        temp_vy = (ay * t) + vy

        return [temp_vx, temp_vy]
    end

    def calc_dist(bodies)
        set_force(calc_force(bodies))
        ax = calc_acc[0]
        ay = calc_acc[1]

        dx = vx + (calc_vel[0] * t)
        dy = vy + (calc_vel[1] * t)

        self.vx = calc_vel[0]
        self.vy = calc_vel[1]

        return [dx, dy]
    end

    def set_coords(bodies)
        self.x += calc_dist(bodies)[0]
        self.y += calc_dist(bodies)[1]
    end

end
