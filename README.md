# AMATH741 - Numerical Partial Differential Equations: Project



* 'matlab' folder contains the matlab files to generate the data associated with PDE problems: Burgers and Korteweg-De Vries (kDV) equations. 

* The generated data for Burgers and kdV equations are stored in data folder. 

* The exact dynamics are plots for generated data. 



** The matlab file needs to install external programs called 'chebfun'. It can be installed via https://www.chebfun.org/download/ and it is compatiable with  MATLAB 7.9 (R2009b) or later**



## Burgers Equation: 

### Inviscid Burgers: 

```math
u_{t} + u u_{x} = 0
```
* domain: 

```math
(x,t) \in [-8,8] \times [0,2]
```


* In the first problem we concern with the initial condition: 
 
```math
u_{0}(x) = u(x,t=0) = - \sin(\pi x/8)
``` 

* In the second problem, we deal with the initial condition 

```math
u_{0}(x) = \cos(-\pi x/8)
```


### Viscid Burgers: 

```math
u_{t} + u u_{x} = 0.1 u_{xx}
```
* domain: 

```math
(x,t) \in [-8,8] \times [0, 10]
```


* In the first problem we concern with the initial condition: 
 
```math
u_{0}(x) = u(x,t=0) = - \sin(\pi x/8)
``` 

* In the second problem, we deal with the initial condition 

```math
u_{0}(x) = \exp(-(x+2)^{2})
```



## Korteweg-de Vries (kdV) equation 

```math
u_{t} + u u_{x} + u_{xxx} = 0 
```


* domain: 

```math
(x,t) \in [-8,8] \times [0,5]
```

* In the first problem we concern with the initial condition 

```math 
u_{0}(x) = - sin(pi (x/8))
```

* In the second problem, we deal with the initial condition 

```math
u_{0}(x) = cos (-pi (x/8))
```

* For details of description for numerical experiment in neural network, see the https://github.com/phuongle0701/AMATH741_project_numerical_pde/blob/main/Numerical_Experiment_Description.pdf

* Also, we modify the author's loss function by adding a regularization L1 to avoid overfitting the model. (Overfitting the model might happen in the case of kdV equation). 

* Technical Programming Issue: 
1. The ```Codes``` folder contains the jupyter notebook to run author's code with our slight modification on GPU-Google Colabs. 
2. The folder ```classical_methods``` contains the Matlab implementation of solving PDE equations numerically: Lax-Friedrichs scheme for Burgers and Leapfrog scheme for kdV equation. 


