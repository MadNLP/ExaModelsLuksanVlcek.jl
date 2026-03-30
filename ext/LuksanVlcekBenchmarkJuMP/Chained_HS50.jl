@inline function LV.Chained_HS50_model(::LV.JuMPBackend, N = 1000; optimizer = nothing, kwargs...)
    nC    = 3 * (N - 1) ÷ 4
    It_L1 = [4 * div(i-1, 3) for i in 1:3:nC-3]
    It_L2 = [4 * div(i-1, 3) for i in 2:3:nC-3]
    It_L3 = [4 * div(i-1, 3) for i in 3:3:nC-3]
    m = optimizer === nothing ? JuMP.Model() : JuMP.Model(optimizer)
    JuMP.@variable(m, x[1:N])
    for i in 1:N
        JuMP.set_start_value(x[i], LV.Chained_HS50_start(i))
    end
    JuMP.@constraint(m, [l in It_L1], LV.Chained_HS50_con1(x, l) == 0)
    JuMP.@constraint(m, [l in It_L2], LV.Chained_HS50_con2(x, l) == 0)
    JuMP.@constraint(m, [l in It_L3], LV.Chained_HS50_con3(x, l) == 0)
    JuMP.@objective(m, Min, sum(LV.Chained_HS50_objective(x, i) for i in 1:floor(Int, (N-1)/4)))
    return m
end
