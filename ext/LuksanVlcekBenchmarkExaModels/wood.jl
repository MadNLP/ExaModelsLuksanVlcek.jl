@inline function LV.wood_model(::LV.ExaModelsBackend, N = 1000; T = Float64, backend = nothing, prod = false, kwargs...)
    c = EM.ExaCore(T; backend = backend, kwargs...)
    EM.@var(c, x, N; start = (iseven(i) ? 0.0 : -2.0 for i = 1:N))
    con = EM.@con(c, (2 + 5 * x[k+5]^2) * x[k+5] + 1 for k in 1:N-7)
    EM.@con!(c, con, k => x[k] * (1 + x[k]) + x[k+1] * (1 + x[k+1]) for k in 1:N-7)
    EM.@obj(c, 100 * (x[2i-1]^2 - x[2i])^2 + (x[2i-1] - 1)^2 +
        90  * (x[2i+1]^2 - x[2i+2])^2 + (x[2i+1] - 1)^2 +
        10  * (x[2i] + x[2i+2] - 2)^2 + (x[2i] - x[2i+2])^2 / 10 for i = 1:N÷2-1)
    return EM.ExaModel(c; prod = prod)
end
