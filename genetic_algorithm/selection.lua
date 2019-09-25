Selection = {}

function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function Selection.elitism(population, num_individuals)
    local individuals = {}
    local num = 1
    for k, ind in spairs(population.individuals, function(pop, ind1, ind2) return pop[ind1].fitness > pop[ind2].fitness end) do
        individuals[num] = ind
        num = num + 1
        if num > num_individuals then
            break
        end
    end
    return individuals
end


function Selection.roulette_wheel(population, num_individuals)
    local individuals = {}
    local wheel = 0.0

    -- Get total wheel sum
    for i = 1, #population.individuals do
        wheel = wheel + population.individuals[i].fitness
    end

    for i = 1, num_individuals do
        local pick = wheel * math.random()
        local current = 0.0
        -- "spin" the wheel by adding all the fitnesses until we are >= pick
        for j = 1, #population.individuals do
            current = current + population.individuals[j].fitness
            if current >= pick then
                individuals[i] = population.individuals[j]
                break
            end
        end

    end

    return individuals
end

function shuffle(tbl, num)
    local total = num or #tbl
    local curr = 1
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
        curr = curr + 1
        if curr > total then
            break
        end
    end
    return tbl
end

function Selection.tournament(population, num_individuals, tournament_size)
    local individuals = {}

    for i = 1, num_individuals do
        local tournament = {}

        -- Creaet array [1, #population.individuals] with values: 1, 2, 3, 4, ..., #population.individuals
        for j = 1, tournament_size do
            tournament[j] = j
        end
        -- Shuffle the array
        tournament = shuffle(tournament, tournament_size)

        -- Add the individuals indexed from the tournament
        local tournament_pop = {}
        for j = 1, #tournament do
            tournament_pop[j] = population.individuals[tournament[j]]
        end

        -- Add the best from the tournament
        for _, ind in spairs(tournament_pop, function(pop, ind1, ind2) return pop[ind1].fitness > pop[ind2].fitness end) do
            individuals[i] = ind
            break
        end
    end

    return individuals
end