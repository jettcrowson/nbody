class Body

    attr_reader :x, :y, :xv, :yv, :mass, :pic

    def initialize(x, y, xv, yv, mass, pic)
        @x = x.to_f
        @y = y.to_f
        @xv = xv.to_f
        @yv = yv.to_f
        @mass = mass.to_f
        @pic = pic
    end

end
