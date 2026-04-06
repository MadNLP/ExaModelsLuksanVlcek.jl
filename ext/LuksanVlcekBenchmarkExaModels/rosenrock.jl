@inline function LV.rosenrock_model(::LV.ExaModelsBackend, N = 1000; T = Float64, backend = nothing, prod = false, kwargs...)
    c = EM.ExaCore(T; backend = backend, kwargs...)
    EM.@var(c, x, N; start = (mod(i, 2) == 1 ? -1.2 : 1.0 for i = 1:N))
    EM.@con(c, 3x[i+1]^3 + 2 * x[i+2] - 5 + sin(x[i+1] - x[i+2])sin(x[i+1] + x[i+2]) + 4x[i+1] - x[i]exp(x[i] - x[i+1]) - 3 for i = 1:N-2)
    EM.@obj(c, 100 * (x[i]^2 - x[i+1])^2 + (x[i] - 1)^2 for i = 1:N-1)
    return EM.ExaModel(c; prod = prod)
end
