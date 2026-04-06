@inline function LV.chained_powell_model(::LV.ExaModelsBackend, N = 1000; T = Float64, backend = nothing, prod = false, kwargs...)
    c = EM.ExaCore(T; backend = backend, kwargs...)
    EM.@var(c, x, N; start = (mod(i, 4) == 1 ? 3.0 : mod(i, 4) == 2 ? -1.0 : mod(i, 4) == 3 ? 0.0 : 1.0 for i = 1:N))
    EM.@con(c, 3 * x[1]^3 + 2 * x[2] - 5 + sin(x[1] - x[2]) * sin(x[1] + x[2]))
    EM.@con(c, 4 * x[N] - x[N-1] * exp(x[N-1] - x[N]) - 3)
    EM.@obj(c, (x[2i-1] + 10 * x[2i])^2 + 5 * (x[2i+1] - x[2i+2])^2 +
               (x[2i] - 2 * x[2i+1])^4 + 10 * (x[2i-1] - x[2i+2])^4 for i = 1:N÷2-1)
    return EM.ExaModel(c; prod = prod)
end
