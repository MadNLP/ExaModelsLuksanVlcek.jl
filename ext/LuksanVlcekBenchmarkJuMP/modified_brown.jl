@inline function LV.modified_brown_model(::LV.JuMPBackend, N = 1000; optimizer = nothing, kwargs...)
    n = Int(N)
    m = optimizer === nothing ? JuMP.Model() : JuMP.Model(optimizer)
    JuMP.@variable(m, x[1:N])
    for i in 1:N
        JuMP.set_start_value(x[i], -1.0)
    end
    JuMP.@constraint(m, LV.modified_brown_constraint1(x) == 0)
    JuMP.@constraint(m, LV.modified_brown_constraint2(x) == 0)
    JuMP.@constraint(m, LV.modified_brown_constraint3(x) == 0)
    JuMP.@constraint(m, LV.modified_brown_constraint4(x, n) == 0)
    JuMP.@constraint(m, LV.modified_brown_constraint5(x, n) == 0)
    JuMP.@constraint(m, LV.modified_brown_constraint6(x, n) == 0)
    JuMP.@objective(m, Min, sum(LV.modified_brown_objective(x, i) for i in 1:N÷2))
    return m
end
