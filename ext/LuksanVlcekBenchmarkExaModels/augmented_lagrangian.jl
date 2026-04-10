@inline function LV.augmented_lagrangian_model(::LV.ExaModelsBackend, N = 1000; T = Float64, backend = nothing, prod = false, kwargs...)
    h  = 1 / (N + 1)
    l1 = LV.augmented_lagrangian_l1
    l2 = LV.augmented_lagrangian_l2
    l3 = LV.augmented_lagrangian_l3
    c  = EM.ExaCore(T; backend = backend, kwargs...)
    EM.@add_variable(c, x, N; start = (LV.augmented_lagrangian_start(i) for i = 1:N))
    EM.@add_constraint(c, LV.augmented_lagrangian_constraint(x, h, k) for k = 1:N-2)
    EM.@add_objective(c, LV.augmented_lagrangian_objective(x, l1, l2, l3, i) for i = 1:N÷5)
    return EM.ExaModel(c; prod = prod)
end
