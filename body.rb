class Body

    attr_reader :x, :y, :xv, :yv, :mass, :pic, :force

    def initialize(x, y, xv, yv, mass, pic)
        @x = x.to_f
        @y = y.to_f
        @xv = xv.to_f
        @yv = yv.to_f
        @mass = mass.to_f
        @pic = pic
        @force = [0.0, 0.0]
    end

    def set_force(f)
        self.force[0] = f[0]
        self.force[1] = f[1]
    end

end
