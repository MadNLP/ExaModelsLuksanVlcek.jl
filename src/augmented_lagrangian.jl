# The following question was adopted from Lukšan, L., & Vlček, J. (1999). Sparse and Partially Separable Test Problems for Unconstrained and Equality Constrained Optimization.
# Institute of Computer Science, Academy of Sciences of the Czech Republic. Technical report No. 767 Problem 5.8

function augmented_lagrangian_model end
augmented_lagrangian_start(i) = mod(i, 2) == 1 ? -1.0 : 2.0
augmented_lagrangian_constraint(x, k, h) = 2 * x[k+1] + h^2 * ((x[k+1] + h * (k+1) + 1)^3) / 2 - x[k] - x[k+2]
function augmented_lagrangian_objective(x, i, l1, l2, l3)
    exp(x[5i] * x[5i-1] * x[5i-2] * x[5i-3] * x[5i-4]) +
    10 * (x[5i]^2 + x[5i-1]^2 + x[5i-2]^2 + x[5i-3]^2 + x[5i-4]^2 - 10 - l1)^2 +
    (x[5i-3] * x[5i-2] - 5 * x[5i-1] * x[5i] - l2)^2 +
    (x[5i-4]^3 + x[5i-3]^3 + 1 - l3)^2
end
