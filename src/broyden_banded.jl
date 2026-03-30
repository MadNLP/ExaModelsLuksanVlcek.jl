# The following question was adopted from Lukšan, L., & Vlček, J. (1999). Sparse and Partially Separable Test Problems for Unconstrained and Equality Constrained Optimization.
# Institute of Computer Science, Academy of Sciences of the Czech Republic. Technical report No. 767 Problem 5.6
# y variable does not exist in the original problem; it is introduced to represent the summation in the objective.

function broyden_banded_model end
broyden_banded_main_constraint(x, k) = 4 * x[2k] - (x[2k-1] - x[2k+1]) * exp(x[2k-1] - x[2k] - x[2k+1]) - 3
broyden_banded_y_constraint_1(x, y) = y[1] - x[1] * (1 + x[1]) - x[2] * (1 + x[2])
broyden_banded_y_constraint_2(x, y) = y[2] - x[2] * (1 + x[2]) - x[3] * (1 + x[3]) - x[1] * (1 + x[1])
broyden_banded_y_constraint_3(x, y) = y[3] - x[2] * (1 + x[2]) - x[3] * (1 + x[3]) - x[1] * (1 + x[1]) - x[4] * (1 + x[4])
broyden_banded_y_constraint_4(x, y) = y[4] - x[2] * (1 + x[2]) - x[3] * (1 + x[3]) - x[1] * (1 + x[1]) - x[4] * (1 + x[4]) - x[5] * (1 + x[5])
broyden_banded_y_constraint_5(x, y) = y[5] - x[2] * (1 + x[2]) - x[3] * (1 + x[3]) - x[1] * (1 + x[1]) - x[4] * (1 + x[4]) - x[5] * (1 + x[5]) - x[6] * (1 + x[6])
broyden_banded_y_constraint_mid(x, y, i) = y[i] - x[i-5] * (1 + x[i-5]) - x[i-4] * (1 + x[i-4]) -
                                            x[i-3] * (1 + x[i-3]) - x[i-2] * (1 + x[i-2]) -
                                            x[i-1] * (1 + x[i-1]) - x[i] * (1 + x[i]) - x[i+1] * (1 + x[i+1])
broyden_banded_y_constraint_last(x, y, n) = y[n] - x[n-5] * (1 + x[n-5]) - x[n-4] * (1 + x[n-4]) -
                                             x[n-3] * (1 + x[n-3]) - x[n-2] * (1 + x[n-2]) -
                                             x[n-1] * (1 + x[n-1]) - x[n] * (1 + x[n])
broyden_banded_objective(x, y, i) = abs((2 + 5 * x[i]^2) * x[i] + 1 + y[i])^7 / 3
