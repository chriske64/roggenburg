# Convex optimization

## Day 1

### Morning lecture (Prof. Crember and Prof. Moeller)
* Basic introduction to convex optimization problems including examples from [Continuous Optimization (Nonlinear and Linear Programming)](https://pdfs.semanticscholar.org/c331/2b37f9a719231b923cbd734654362dd26853.pdf)
* Newton method: for second order system, i.e. where either the loss functions or constraints involve second order differential operators.
* More detailed example on computer vision for self-driving cars
  * Obstacle avoidance
  * [Slam problems](https://de.wikipedia.org/wiki/Simultaneous_Localization_and_Mapping)
* Example: 3D reconstruction from images
  * compute surface of object which leads to infinite-dimensional optimization and by discretization to a very high dimensional problem ($~10^{40\,  \mathrm{Mio.}}$)
  * problems of such difficulty should be written or formed into convex problems; o/w bad scaling properties
    * Two major problems: How to minimize convex problems? How to perform the convex relaxation? Standard method for first problem: gradient descent
    * cameras have huge advantages to laser scanner: omnipresence
    * Interesting (unsolved!) problem for 3D video reconstruction: can one also solve Newton's equation, ie. momentum and energy constraints on reconstruction
* Inverse problems: Denoising $u_{den} =  \operatorname{argmin}_{u} \int_\Omega (u-f)^2 dx + \lambda \int_{\Omega} |\nabla u| dx$.
  * Dirichlet energy: penalizes sharp edges, does not penalize noising
  * TV regularization: Does the opposite to some extend.
* Brief intro to variational calculus and applications
  * Gateaux derivative
  * Euler equation (aka Euler-Lagrange equation in non-German speaking parts)
  * Gradient descent
  * Dirichlet energy -> linear diffusion
  * TV regularization -> nonlinear diffusion; good for denoising as sharp edges are less penalized
### Afternoon

* started with implementation

## Day 2

### Morning lecture

#### First part (Prof. Cremers)

* Review of basic convex optimization
  * differentiability
  * convex energy and minimization problems
  * gradient descent
    * constant step-size is bad: possible oscillation around optimum
  * More technical concepts: closedness, coercivity, lower semi-continuity; these concepts are need to ensure the existence of minimizers and rule out pathological examples
  * gradient projection
    * projection for on a convex closed set C $\pi_C(v) = \operatorname{argmin}_{u\in C} E(u)$
    * gradient projection: iteratively do gradient descent and project onto convex set
  * Minimizing non-smooth problems
    * proximal gradient for sum of smooth and non-smooth function in loss functions
    * prox is generalisation of projection: given closed, proper, convex function $G:\mathbb{R}^n \to \mathbb{R} \cup \{\infty\}$ the map $\operatorname{prox}_G(v) = \operatorname{argmin}_{u\in \mathbb{R}^n} G(u) + \frac 12 \| u - v\|^2$
    * proximal operator as implicit gradient descent $u_{k+1} = u_k - \nabla G (u_{k+1})$ if $u_{k+1} = \operatorname{prox}_G u_{k}$
    * examples of proximals

#### Second part (Prof. Moeller)

* quick recap of proximal gradient
* motiviation: $\min_u \| Au - f\|_{1}$, although the proximal matpping of the $\ell^1$ norm is easy to compute
* leads to augmented Lagrangian aka ADMM algorithm


## Day 4

#### Morning lecture (Prof. Moeller)

* Introduction to FISTA: convergence of $ O(1/k^2 ) $ which is actually sharp
*
