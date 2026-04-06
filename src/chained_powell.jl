# The following question was adopted from Lukšan, L., & Vlček, J. (1999). Sparse and Partially Separable Test Problems for Unconstrained and Equality Constrained Optimization.
# Institute of Computer Science, Academy of Sciences of the Czech Republic. Technical report No. 767 Problem 5.3

function chained_powell_model end
@inline chained_powell_start(i) = mod(i, 4) == 1 ? 3.0 : mod(i, 4) == 2 ? -1.0 : mod(i, 4) == 3 ? 0.0 : 1.0
@inline chained_powell_con1(x) = 3 * x[1]^3 + 2 * x[2] - 5 + sin(x[1] - x[2]) * sin(x[1] + x[2])
@inline chained_powell_con_n(x, n) = 4 * x[n] - x[n-1] * exp(x[n-1] - x[n]) - 3
@inline chained_powell_objective(x, i) = (x[2i-1] + 10 * x[2i])^2 + 5 * (x[2i+1] - x[2i+2])^2 +
                                  (x[2i] - 2 * x[2i+1])^4 + 10 * (x[2i-1] - x[2i+2])^4
