@inline function LV.broyden_tridiagonal_model(::LV.JuMPBackend, N = 1000; optimizer = nothing, kwargs...)
    m = optimizer === nothing ? JuMP.Model() : JuMP.Model(optimizer)
    JuMP.@variable(m, x[1:N])
    for i in 1:N
        JuMP.set_start_value(x[i], -1.0)
    end
    JuMP.@constraint(m, [k = 1:N-4], LV.broyden_tridiagonal_constraint(x, k) == 0)
    JuMP.@objective(m, Min,
        sum(LV.broyden_tridiagonal_objective(x, i) for i in 2:N-1) +
        abs((3 - 2 * x[1]) * x[1] - x[2] + 1)^7 / 3 +
        abs((3 - 2 * x[N]) * x[N] - x[N-1] + 1)^7 / 3
    )
    return m
end
