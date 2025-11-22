function pollards_pho(n, x0=1, c=5)
    f(x) = (x^2 + c) % n
    a=b=x0
    d = 1
    while d == 1
        a = f(a)
        b = f(f(b))
        d = gcd(abs(a - b), n)
    end
    return d == n ? nothing : d
end

n = 1359331
factor = pollards_pho(n, 1, 5)

println("Нетривиальный делитель числа $n: $factor")