# ColorCorrectionProject

The folder `Matlab/solution_methods/` contains various methods to minimize the color difference.

Solve nonlinear, constrained problem with FIPCO.
`intensity_difference_solver.m`

Solve nonlinear, constrained problem with a penalized Newton's Method. Requires objective functions in `Matlab/my_diff_quad_penalty/`.
`min_diff_penalty_newton.m`
 
Solve nonlinear, constrained problem with SQP. Requires objective functions in `Matlab/lagrangian/`.
`min_diff_SQP.m`

Solve linear, constrained problem.
`linearScalingGammasInt.m` 
 
Ordinary objective function, gradient, and Hessian found in `Matlab/my_diff/` and `Matlab/my_intensity`.
