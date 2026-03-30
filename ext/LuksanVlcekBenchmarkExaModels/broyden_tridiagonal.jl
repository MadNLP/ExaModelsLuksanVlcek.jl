@inline function LV.broyden_tridiagonal_model(::LV.ExaModelsBackend, N = 1000; T = Float64, backend = nothing, prod = false, kwargs...)
    c = EM.ExaCore(T; backend = backend, kwargs...)
    EM.@var(c, x, N; start = fill(-1, N))
    EM.@con(c, LV.broyden_tridiagonal_constraint(x, k) for k = 1:N-4)
    EM.@obj(c, LV.broyden_tridiagonal_objective(x, i) for i = 2:N-1)
    EM.@obj(c, abs((3 - 2 * x[1]) * x[1] - x[2] + 1)^7 / 3 + abs((3 - 2 * x[N]) * x[N] - x[N-1] + 1)^7 / 3)
    return EM.ExaModel(c; prod = prod)
end
