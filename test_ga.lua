require("genetic_algorithm/individual")
require("genetic_algorithm/population")
require("genetic_algorithm/mutation")
require("genetic_algorithm/crossover")
require("genetic_algorithm/mutation")
require("genetic_algorithm/selection")

function run_test(print_intermediate)
    local individuals = {}
    local population = Population:new()
    local generation = 1

    for i=1,100 do
        individuals[i] = Individual:create_random_individual()
    end

    population:set_individuals(individuals)
    population:calculate_fitness()
    print(Selection.elitism(population, 1)[1].fitness)
 
    for i=1,500 do
        print("generation", i)
        population:calculate_fitness()
        print("-- avg fitness", population:calculate_average_fitness(false))

        -- Set individuals for reproducing
        local best = Selection.elitism(population, 100)
        best = shuffle(best)
        population:set_individuals(best)

        local next_pop = {}
        for i = 1, #population.individuals do
            next_pop[i] = population.individuals[i]
        end
        local b = Selection.elitism(population, 1)[1]
        print(string.format("-- best (x,y)= (%f, %f)", b.chromosome[1], b.chromosome[2]))

        while #next_pop < 200 do
            local parents = Selection.roulette_wheel(population, 2)
            local p1, p2 = parents[1], parents[2]
            
            -- Crossover
            local c1_chromosome, c2_chromosome = Crossover.SBX(p1.chromosome, p2.chromosome, 1)
            local c1 = Individual:new()
            c1.chromosome = c1_chromosome
            local c2 = Individual:new()
            c2.chromosome = c2_chromosome
            
            -- Mutation
            Mutation.gaussian(c1.chromosome, 0.05)
            Mutation.gaussian(c2.chromosome, 0.05)

            next_pop[#next_pop + 1] = c1
            next_pop[#next_pop + 1] = c2
        end

        population:set_individuals(next_pop)
    end

    population:calculate_fitness()
    print(Selection.elitism(population, 1)[1].fitness)

end