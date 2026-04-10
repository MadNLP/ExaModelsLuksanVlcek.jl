@inline function LV.augmented_lagrangian_model(::LV.JuMPBackend, N = 1000; optimizer = nothing, kwargs...)
    h  = 1 / (N + 1)
    l1 = LV.augmented_lagrangian_l1
    l2 = LV.augmented_lagrangian_l2
    l3 = LV.augmented_lagrangian_l3
    m  = optimizer === nothing ? JuMP.Model() : JuMP.Model(optimizer)
    JuMP.@variable(m, x[1:N])
    for i in 1:N
        JuMP.set_start_value(x[i], LV.augmented_lagrangian_start(i))
    end
    JuMP.@constraint(m, [k = 1:N-2], LV.augmented_lagrangian_constraint(x, h, k) == 0)
    JuMP.@objective(m, Min, sum(LV.augmented_lagrangian_objective(x, l1, l2, l3, i) for i in 1:N÷5))
    return m
end
