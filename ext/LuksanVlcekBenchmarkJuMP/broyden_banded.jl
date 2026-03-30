@inline function LV.broyden_banded_model(::LV.JuMPBackend, N = 1000; optimizer = nothing, kwargs...)
    n = Int(N)
    m = optimizer === nothing ? JuMP.Model() : JuMP.Model(optimizer)
    JuMP.@variable(m, x[1:N])
    JuMP.@variable(m, y[1:N])
    for i in 1:N
        JuMP.set_start_value(x[i], 3.0)
        JuMP.set_start_value(y[i], 0.0)
    end
    JuMP.@constraint(m, [k = 1:N÷2], LV.broyden_banded_main_constraint(x, k) == 0)
    JuMP.@constraint(m, LV.broyden_banded_y_constraint_1(x, y) == 0)
    JuMP.@constraint(m, LV.broyden_banded_y_constraint_2(x, y) == 0)
    JuMP.@constraint(m, LV.broyden_banded_y_constraint_3(x, y) == 0)
    JuMP.@constraint(m, LV.broyden_banded_y_constraint_4(x, y) == 0)
    JuMP.@constraint(m, LV.broyden_banded_y_constraint_5(x, y) == 0)
    JuMP.@constraint(m, [i = 6:N-1], LV.broyden_banded_y_constraint_mid(x, y, i) == 0)
    JuMP.@constraint(m, LV.broyden_banded_y_constraint_last(x, y, n) == 0)
    JuMP.@objective(m, Min, sum(LV.broyden_banded_objective(x, y, i) for i in 1:N))
    return m
end
