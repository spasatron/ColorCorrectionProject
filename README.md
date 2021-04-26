# ColorCorrectionProject

The folder `Matlab/solution_methods/` contains various methods to minimize the color difference.

`intensity_difference_solver.m`: Solve nonlinear, constrained problem with FIPCO.

`min_diff_penalty_newton.m`: Solve nonlinear, constrained problem with a penalized Newton's Method. Requires objective functions in `Matlab/my_diff_quad_penalty/`.
 
`min_diff_SQP.m`: Solve nonlinear, constrained problem with SQP. Requires objective functions in `Matlab/lagrangian/`.

`linearScalingGammasInt.m`: Solve linear, constrained problem.
 
Objective functions, gradients, and Hessians found in `Matlab/my_diff/` and `Matlab/my_intensity`.
