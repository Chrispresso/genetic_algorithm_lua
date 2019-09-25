require("random")
Mutation = {}

function Mutation.gaussian(chromosome, prob_mutation, mu, sigma, scale)
    local mu = mu or 0
    local sigma = sigma or 1
    local scale = scale or 1

    -- Mutate
    for gene = 1, #chromosome do
        -- Mutate at certain probability
        if  math.random() < prob_mutation then
            chromosome[gene] = chromosome[gene] + Random.random_gaussian(mu, sigma)
        end
    end
end
