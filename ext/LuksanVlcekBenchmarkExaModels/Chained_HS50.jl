@inline function LV.Chained_HS50_model(::LV.ExaModelsBackend, N = 1000; T = Float64, backend = nothing, prod = false, kwargs...)
    nC    = 3 * (N - 1) ÷ 4
    It_L1 = [4 * div(i-1, 3) for i in 1:3:nC-3]
    It_L2 = [4 * div(i-1, 3) for i in 2:3:nC-3]
    It_L3 = [4 * div(i-1, 3) for i in 3:3:nC-3]
    c = EM.ExaCore(T; backend = backend, kwargs...)
    EM.@add_variable(c, x, N; start = (LV.Chained_HS50_start(i) for i = 1:N))
    EM.@add_constraint(c, LV.Chained_HS50_constraint1(x, l) for l in It_L1)
    EM.@add_constraint(c, LV.Chained_HS50_constraint2(x, l) for l in It_L2)
    EM.@add_constraint(c, LV.Chained_HS50_constraint3(x, l) for l in It_L3)
    EM.@add_objective(c, LV.Chained_HS50_objective(x, i) for i in 1:floor(Int, (N-1)/4))
    return EM.ExaModel(c; prod = prod)
end
