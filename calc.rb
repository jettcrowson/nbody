module Calc

    def Calc.how_far(b1,b2)
        dx = (b2.x - b1.x)
        dy = (b2.y - b1.y)

        return [dx, dy]
    end

    def Calc.length(b1, b2)
        d = Calc.how_far(b1,b2)

        return Math.sqrt(d[0] ** 2 + d[1] ** 2)
    end

    def Calc.force(m1, m2, r)
        g = 6.67408 * (10 ** -11)
        return (g * m1 * m2) / (r ** 2)
    end

    def Calc.force_directional(f, d, r)
        return f * (d / r)
    end

    def Calc.acceleration(f, m)
        return f / m
    end

    def Calc.velocity(a, v0)
        return (a * 25000) + v0
    end

    def Calc.distance(v0, v)
        return v0 + (v * 25000)
    end

end
