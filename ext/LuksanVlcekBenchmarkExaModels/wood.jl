@inline function LV.wood_model(::LV.ExaModelsBackend, N = 1000; T = Float64, backend = nothing, prod = false, kwargs...)
    c = EM.ExaCore(T; backend = backend, kwargs...)
    EM.@var(c, x, N; start = (LV.wood_start(i) for i = 1:N))
    con = EM.@con(c, LV.wood_constraint(x, k) for k in 1:N-7)
    EM.@con!(c, con, k => LV.wood_constraint_aug(x, k) for k in 1:N-7)
    EM.@obj(c, LV.wood_objective(x, i) for i = 1:N÷2-1)
    return EM.ExaModel(c; prod = prod)
end
