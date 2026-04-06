# The following question was adopted from Lukšan, L., & Vlček, J. (1999). Sparse and Partially Separable Test Problems for Unconstrained and Equality Constrained Optimization.
# Institute of Computer Science, Academy of Sciences of the Czech Republic. Technical report No. 767 Problem 5.2

function wood_model end
wood_start(i) = iseven(i) ? 0.0 : -2.0
wood_constraint(x, k) = (2 + 5 * x[k+5]^2) * x[k+5] + 1
wood_constraint_aug(x, k) = x[k] * (1 + x[k]) + x[k+1] * (1 + x[k+1])
@inline wood_objective(x, i) = 100 * (x[2i-1]^2 - x[2i])^2 + (x[2i-1] - 1)^2 +
                        90  * (x[2i+1]^2 - x[2i+2])^2 + (x[2i+1] - 1)^2 +
                        10  * (x[2i] + x[2i+2] - 2)^2 + (x[2i] - x[2i+2])^2 / 10
