@inline function LV.augmented_lagrangian_model(::LV.ExaModelsBackend, N = 1000; T = Float64, backend = nothing, prod = false, kwargs...)
    h  = 1 / (N + 1)
    l1 = -0.002008
    l2 = -0.001900
    l3 = -0.000261
    c  = EM.ExaCore(T; backend = backend, kwargs...)
    EM.@var(c, x, N; start = (LV.augmented_lagrangian_start(i) for i = 1:N))
    EM.@con(c, LV.augmented_lagrangian_constraint(x, k, h) for k = 1:N-2)
    EM.@obj(c, LV.augmented_lagrangian_objective(x, i, l1, l2, l3) for i = 1:N÷5)
    return EM.ExaModel(c; prod = prod)
end
