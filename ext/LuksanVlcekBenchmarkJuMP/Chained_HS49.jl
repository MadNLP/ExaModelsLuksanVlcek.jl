@inline function LV.Chained_HS49_model(::LV.JuMPBackend, N = 1000; optimizer = nothing, kwargs...)
    nC    = 2 * (N - 2) ÷ 3
    It_L1 = [3 * div(i-1, 2) for i in 1:2:nC-1]
    It_L2 = [3 * div(i-1, 2) for i in 2:2:nC]
    m = optimizer === nothing ? JuMP.Model() : JuMP.Model(optimizer)
    JuMP.@variable(m, x[1:N])
    for i in 1:N
        JuMP.set_start_value(x[i], LV.Chained_HS49_start(i))
    end
    JuMP.@constraint(m, [l in It_L1], LV.Chained_HS49_constraint1(x, l) == 0)
    JuMP.@constraint(m, [l in It_L2], LV.Chained_HS49_constraint2(x, l) == 0)
    JuMP.@objective(m, Min, sum(LV.Chained_HS49_objective(x, i) for i in 1:floor(Int, (N-2)/3)))
    return m
end
