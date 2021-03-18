# AMATH741 - Numerical Partial Differential Equations: Project



* 'matlab' folder contains the matlab files to generate the data associated with PDE problems: Burgers and Korteweg-De Vries (kDV) equations. 

* The generated data for Burgers and kdV equations are stored in data folder. 

* The exact dynamics are plots for generated data. 



** The matlab file needs to install external programs called 'chebfun'. It can be installed via https://www.chebfun.org/download/ and it is compatiable with  MATLAB 7.9 (R2009b) or later**



## Burgers Equation: 

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
(x,t) \in [-20,20] \times [0, 40]
```

* In the first problem we concern with the initial condition 

```math 
u_{0}(x) = -\sin(\pi x/20)
```

* In the second problem, we deal with the initial condition 

```math
u_{0}(x) = \cos(-\pi x/20) 
```






$$x_{1,2} = \frac{-b \pm \sqrt{b^2-4ac}}{2b}.$$

<script type="text/javascript" async

src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
