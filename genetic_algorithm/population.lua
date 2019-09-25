Population = {}

function Population:new()
    local o = {}
    o.individuals = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Population:set_individuals(individuals)
    self.individuals = individuals
end

function Population:calculate_fitness()
    for _, individual in pairs(self.individuals) do
        individual:calculate_fitness()
    end
end

function Population:calculate_average_fitness(calculate)
    local calculate_fitness = calculate_fitness or true

    if calculate_fitness then
        self:calculate_fitness()
    end

    local total = 0.0
    for i = 1, #self.individuals do
        total = total + self.individuals[i].fitness
    end

    return total / #self.individuals
end