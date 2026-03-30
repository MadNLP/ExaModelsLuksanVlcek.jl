@inline function LV.Chained_HS49_model(::LV.ExaModelsBackend, N = 1000; T = Float64, backend = nothing, prod = false, kwargs...)
    nC    = 2 * (N - 2) ÷ 3
    It_L1 = [3 * div(i-1, 2) for i in 1:2:nC-1]
    It_L2 = [3 * div(i-1, 2) for i in 2:2:nC]
    c = EM.ExaCore(T; backend = backend, kwargs...)
    EM.@var(c, x, N; start = (LV.Chained_HS49_start(i) for i = 1:N))
    EM.@con(c, LV.Chained_HS49_con1(x, l) for l in It_L1)
    EM.@con(c, LV.Chained_HS49_con2(x, l) for l in It_L2)
    EM.@obj(c, LV.Chained_HS49_objective(x, i) for i in 1:floor(Int, (N-2)/3))
    return EM.ExaModel(c; prod = prod)
end
