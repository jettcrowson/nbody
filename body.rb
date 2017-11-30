class Body

    attr_reader :x, :y, :xv, :yv, :mass, :pic, :force, :g, :ax, :ay

    def initialize(x, y, xv, yv, mass, pic)
        @x = x.to_f
        @y = y.to_f
        @xv = xv.to_f
        @yv = yv.to_f
        @mass = mass.to_f
        @pic = pic
        @force = [0.0, 0.0]
        @ax = 0.0
        @ay = 0.0

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

        set_force([fx, fy])
    end

    def calc_acc
        self.ax = body.force[0] / body.mass
        self.ay = body.force[1] / body.mass
    end

end
