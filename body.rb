require "./calc"

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
    end

    def set_force(f)
        self.force[0] = f[0]
        self.force[1] = f[1]
    end

    def calc_force(bodies)
        f, fx, fy, dx, dy, r = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        
        bodies.each do |body2|
            next if body2 == self
            r = Calc.length(self, body2)
            dx = Calc.how_far(self, body2)[0]
            dy = Calc.how_far(self, body2)[1]

            f += Calc.force(mass, body2.mass, r)
        end

        fx = Calc.force_directional(f, dx, r)
        fy = Calc.force_directional(f, dy, r)

        return [fx, fy]
    end

    def set_coords(bodies)
        set_force(calc_force(bodies))

        v0x = vx
        v0y = vy

        ax = Calc.acceleration(force[0], mass)
        ay = Calc.acceleration(force[1], mass)

        self.vx = Calc.velocity(ax, v0x)
        self.vy = Calc.velocity(ay, v0y)

        self.x += Calc.distance(v0x, vx)
        self.y += Calc.distance(v0y, vy)
    end

end
