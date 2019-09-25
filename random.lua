Random = {}

math.randomseed(os.time())

function Random.random_gaussian(mu, sigma)
    local u1 = math.random()
    local u2 = math.random()
    local z = math.sqrt(-2.0 * math.log(u1)) * math.cos(2 * math.pi * u2)
    return z * sigma + mu
end