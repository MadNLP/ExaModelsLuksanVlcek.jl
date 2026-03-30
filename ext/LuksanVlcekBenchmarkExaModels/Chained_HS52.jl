@inline function LV.Chained_HS52_model(::LV.ExaModelsBackend, N = 1000; T = Float64, backend = nothing, prod = false, kwargs...)
    nC    = 3 * (N - 1) ÷ 4
    It_L1 = [4 * div(i-1, 3) for i in 1:3:nC-3]
    It_L2 = [4 * div(i-1, 3) for i in 2:3:nC-3]
    It_L3 = [4 * div(i-1, 3) for i in 3:3:nC-3]
    c = EM.ExaCore(T; backend = backend, kwargs...)
    EM.@var(c, x, N; start = fill(2.0, N))
    EM.@con(c, LV.Chained_HS52_con1(x, l) for l in It_L1)
    EM.@con(c, LV.Chained_HS52_con2(x, l) for l in It_L2)
    EM.@con(c, LV.Chained_HS52_con3(x, l) for l in It_L3)
    EM.@obj(c, LV.Chained_HS52_objective(x, i) for i in 1:floor(Int, (N-1)/4))
    return EM.ExaModel(c; prod = prod)
end
