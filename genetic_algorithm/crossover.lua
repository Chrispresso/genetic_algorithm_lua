Crossover = {}
math.random(os.time())
function Crossover.SBX(parent1_chromosome, parent2_chromosome, eta)
    -- Create random [0,1) same size as parents chromosome
    local rand = {}
    for i = 1, #parent1_chromosome do
        rand[i] = math.random()
    end

    -- Calculate gamma
    local gamma = {}
    for i = 1, #parent1_chromosome do
        if rand[i] <= 0.5 then
            gamma[i] = math.pow( (2.0 * rand[i]), (1.0 / (eta + 1)) )
        else
            gamma[i] = math.pow( (1.0 / (2.0 * (1.0 - rand[i]))), (1.0 / (eta + 1)) )
        end

    end

    -- Calculate child 1 and child 2 chromosome
    local chromosome1 = {}
    local chromosome2 = {}
    for gene, _ in pairs(gamma) do
        chromosome1[gene] = 0.5 * ((1 + gamma[gene]) * parent1_chromosome[gene] + (1 - gamma[gene]) * parent2_chromosome[gene])
        chromosome2[gene] = 0.5 * ((1 - gamma[gene]) * parent1_chromosome[gene] + (1 + gamma[gene]) * parent2_chromosome[gene])
    end

    return chromosome1, chromosome2
end