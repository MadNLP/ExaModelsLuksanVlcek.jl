@inline function LV.wood_model(::LV.JuMPBackend, N = 1000; optimizer = nothing, kwargs...)
    m = optimizer === nothing ? JuMP.Model() : JuMP.Model(optimizer)
    JuMP.@variable(m, x[1:N])
    for i in 1:N
        JuMP.set_start_value(x[i], LV.wood_start(i))
    end
    JuMP.@constraint(m, [k = 1:N-7], LV.wood_constraint(x, k) + LV.wood_constraint_aug(x, k) == 0)
    JuMP.@objective(m, Min, sum(LV.wood_objective(x, i) for i in 1:N÷2-1))
    return m
end
