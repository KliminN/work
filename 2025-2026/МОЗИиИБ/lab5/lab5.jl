function fermat_test(n::Int)
    if n ≤ 5 || iseven(n)
        return "n должно быть нечётным и > 5"
    end
    a = rand(3:n-2)
    return powermod(a, n-1, n) == 1 ? "число $n, вероятно, простое" : "число $n составное"
end

function solovay_strassen(n::Int)
    if n ≤ 3 || iseven(n) return "n должно быть нечётным и > 3" end

    function jacobi(a,n)
        r=1; a=mod(a,n)
        while a!=0
            while iseven(a)
                a>>=1
                if n%8==3 || n%8==5 r=-r end
            end
            a,n=n,a
            if a%4==3 && n%4==3 r=-r end
            a=mod(a,n)
        end
        return n==1 ? r : 0
    end

    a = rand(2:n-2)
    r = powermod(a,(n-1)÷2,n)
    j = jacobi(a,n)
    j = j == -1 ? n-1 : j

    return r==j ? "число $n, вероятно, простое" : "число $n составное"
end

function miller_rabin(n::Int)
    if n ≤ 5 || iseven(n) return "n должно быть нечётным и > 5" end

    d = n - 1
    s = 0
    while iseven(d)
        d >>= 1
        s += 1
    end

    a = rand(2:n-2)
    x = powermod(a,d,n)
    if x == 1 || x == n-1
        return "число $n, вероятно, простое"
    end

    for _ in 1:(s-1)
        x = powermod(x,2,n)
        if x == n-1
            return "число $n, вероятно, простое"
        elseif x == 1
            return "число $n составное"
        end
    end

    return "число $n составное"
end

n = 17

println(fermat_test(n))
println(solovay_strassen(n))
println(miller_rabin(n))
