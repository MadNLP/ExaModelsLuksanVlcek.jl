# The following question was adopted from Lukšan, L., & Vlček, J. (1999). Sparse and Partially Separable Test Problems for Unconstrained and Equality Constrained Optimization.
# Institute of Computer Science, Academy of Sciences of the Czech Republic. Technical report No. 767 Problem 5.11
# The index in nC would be out of range for constraints where mod(k,2)==1; the last constraint is therefore not implemented.

function Chained_HS46_model end
Chained_HS46_start(i) = mod(i, 3) == 1 ? 2.0 : mod(i, 3) == 2 ? 1.5 : 0.5
Chained_HS46_con1(x, l) = x[l+2] + x[l+3]^4 * x[l+4]^2 - 2
Chained_HS46_con2(x, l) = x[l+1]^2 * x[l+4] + sin(x[l+4] - x[l+5]) - 1
Chained_HS46_objective(x, i) = (x[3(i-1)+1] - x[3(i-1)+2])^2 + (x[3(i-1)+3] - 1)^2 +
                                (x[3(i-1)+4] - 1)^4 + (x[3(i-1)+5] - 1)^6
