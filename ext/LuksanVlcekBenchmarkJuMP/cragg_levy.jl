@inline function LV.cragg_levy_model(::LV.JuMPBackend, N = 1000; optimizer = nothing, kwargs...)
    m = optimizer === nothing ? JuMP.Model() : JuMP.Model(optimizer)
    JuMP.@variable(m, x[1:N])
    for i in 1:N
        JuMP.set_start_value(x[i], LV.cragg_levy_start(i))
    end
    JuMP.@constraint(m, [k = 1:N-2], LV.cragg_levy_constraint(x, k) == 0)
    JuMP.@objective(m, Min, sum(LV.cragg_levy_objective(x, i) for i in 1:N÷2-1))
    return m
end
