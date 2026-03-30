@inline function LV.augmented_lagrangian_model(::LV.JuMPBackend, N = 1000; optimizer = nothing, kwargs...)
    h  = 1 / (N + 1)
    l1 = -0.002008
    l2 = -0.001900
    l3 = -0.000261
    m  = optimizer === nothing ? JuMP.Model() : JuMP.Model(optimizer)
    JuMP.@variable(m, x[1:N])
    for i in 1:N
        JuMP.set_start_value(x[i], LV.augmented_lagrangian_start(i))
    end
    JuMP.@constraint(m, [k = 1:N-2], LV.augmented_lagrangian_constraint(x, k, h) == 0)
    JuMP.@objective(m, Min, sum(LV.augmented_lagrangian_objective(x, i, l1, l2, l3) for i in 1:N÷5))
    return m
end
