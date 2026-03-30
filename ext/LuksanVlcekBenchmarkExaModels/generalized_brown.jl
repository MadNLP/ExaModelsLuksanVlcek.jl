@inline function LV.generalized_brown_model(::LV.ExaModelsBackend, N = 1000; T = Float64, backend = nothing, prod = false, kwargs...)
    c = EM.ExaCore(T; backend = backend, kwargs...)
    EM.@var(c, x, N; start = fill(-1, N))
    EM.@con(c, LV.generalized_brown_constraint(x, k) for k = 1:N-2)
    EM.@obj(c, LV.generalized_brown_objective(x, i) for i = 1:N÷2)
    return EM.ExaModel(c; prod = prod)
end
