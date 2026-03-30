@inline function LV.generalized_brown_model(::LV.JuMPBackend, N = 1000; optimizer = nothing, kwargs...)
    m = optimizer === nothing ? JuMP.Model() : JuMP.Model(optimizer)
    JuMP.@variable(m, x[1:N])
    for i in 1:N
        JuMP.set_start_value(x[i], -1.0)
    end
    JuMP.@constraint(m, [k = 1:N-2], LV.generalized_brown_constraint(x, k) == 0)
    JuMP.@objective(m, Min, sum(LV.generalized_brown_objective(x, i) for i in 1:N÷2))
    return m
end
