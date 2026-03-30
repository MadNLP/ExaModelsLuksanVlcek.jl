@inline function LV.chained_powell_model(::LV.ExaModelsBackend, N = 1000; T = Float64, backend = nothing, prod = false, kwargs...)
    c = EM.ExaCore(T; backend = backend, kwargs...)
    EM.@var(c, x, N; start = (LV.chained_powell_start(i) for i = 1:N))
    EM.@con(c, LV.chained_powell_con1(x))
    EM.@con(c, LV.chained_powell_con_n(x, N))
    EM.@obj(c, LV.chained_powell_objective(x, i) for i = 1:N÷2-1)
    return EM.ExaModel(c; prod = prod)
end
