class Body

    attr_reader :x, :y, :xv, :yv, :mass, :pic

    def initialize(x, y, xv, yv, mass, pic)
        @x = x
        @y = y
        @xv = xv
        @yv = yv
        @mass = mass
        @pic = pic
    end

end
