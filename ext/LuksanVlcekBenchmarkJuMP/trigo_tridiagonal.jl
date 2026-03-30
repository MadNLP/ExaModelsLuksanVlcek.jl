@inline function LV.trigo_tridiagonal_model(::LV.JuMPBackend, N = 1000; optimizer = nothing, kwargs...)
    n = N
    m = optimizer === nothing ? JuMP.Model() : JuMP.Model(optimizer)
    JuMP.@variable(m, x[1:N])
    for i in 1:N
        JuMP.set_start_value(x[i], 1.0)
    end
    JuMP.@constraint(m, LV.trigo_tridiagonal_con1(x) == 0)
    JuMP.@constraint(m, LV.trigo_tridiagonal_con2(x) == 0)
    JuMP.@constraint(m, LV.trigo_tridiagonal_con_n1(x, n) == 0)
    JuMP.@constraint(m, LV.trigo_tridiagonal_con_n(x, n) == 0)
    JuMP.@objective(m, Min, sum(LV.trigo_tridiagonal_objective(x, i) for i in 2:N-1))
    return m
end
