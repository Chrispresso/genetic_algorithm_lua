Individual = {}
Individual_mt = {}

math.randomseed(os.time())
fitness_function = function(x, y)
    local fxy = 2*x*x - 1.05*math.pow(x,4) + (math.pow(x, 6)/6) + x*y + y*y
    return 1.0 / (fxy)
end

function Individual:new(x, y)
    local o = {}
    o.chromosome = {}
    o.fitness = 0.1
    o.chromosome = {}
    o.chromosome[1] = x or -5
    o.chromosome[2] = y or -5
    setmetatable(o, self)
    self.__index = self
    return o
end

function Individual:create_random_individual()
    local hi = 10
    local lo = 1

    local x = (hi - lo) * math.random() + lo
    local y = (hi - lo) * math.random() + lo
    local ind = Individual:new(x, y)
    return ind 
end

function Individual:calculate_fitness()
    self.fitness = fitness_function(self.chromosome[1], self.chromosome[2])
end