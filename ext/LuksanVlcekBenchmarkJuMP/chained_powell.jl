@inline function LV.chained_powell_model(::LV.JuMPBackend, N = 1000; optimizer = nothing, kwargs...)
    m = optimizer === nothing ? JuMP.Model() : JuMP.Model(optimizer)
    JuMP.@variable(m, x[1:N])
    for i in 1:N
        JuMP.set_start_value(x[i], LV.chained_powell_start(i))
    end
    JuMP.@constraint(m, LV.chained_powell_con1(x) == 0)
    JuMP.@constraint(m, LV.chained_powell_con_n(x, N) == 0)
    JuMP.@objective(m, Min, sum(LV.chained_powell_objective(x, i) for i in 1:N÷2-1))
    return m
end
