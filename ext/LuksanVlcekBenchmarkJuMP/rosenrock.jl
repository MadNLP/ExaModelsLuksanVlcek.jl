@inline function LV.rosenrock_model(::LV.JuMPBackend, N = 1000; optimizer = nothing, kwargs...)
    m = optimizer === nothing ? JuMP.Model() : JuMP.Model(optimizer)
    JuMP.@variable(m, x[1:N])
    for i in 1:N
        JuMP.set_start_value(x[i], LV.rosenrock_start(i))
    end
    JuMP.@constraint(m, [i = 1:N-2], LV.rosenrock_constraint(x, i) == 0)
    JuMP.@objective(m, Min, sum(LV.rosenrock_objective(x, i) for i in 1:N-1))
    return m
end
