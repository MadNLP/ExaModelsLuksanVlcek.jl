@inline function LV.generalized_brown_model(::LV.ExaModelsBackend, N = 1000; T = Float64, backend = nothing, prod = false, kwargs...)
    c = EM.ExaCore(T; backend = backend, kwargs...)
    EM.@add_variable(c, x, N; start = fill(-1, N))
    EM.@add_constraint(c, LV.generalized_brown_constraint(x, k) for k = 1:N-2)
    EM.@add_objective(c, LV.generalized_brown_objective(x, i) for i = 1:N÷2)
    return EM.ExaModel(c; prod = prod)
end
