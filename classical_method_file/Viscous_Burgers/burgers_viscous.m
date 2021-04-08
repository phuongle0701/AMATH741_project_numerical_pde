function burgers_viscous
clc; 
clear all; 
format short; 
% domain of x: 
N=256; % space grid. 
a=-8; 
b=8; 
dx=(b-a)/N;
Tmax=10; % maximum time. 
epsilon=0.1; % the constant damping in the equation.
% discretize the space: 
x=linspace(a,b,N)';
pausetime=0.00001;

% set up the storage: 
u=zeros(N,1);
unew=zeros(N,1); 
% storage for the pcolor plot: 
Vals=[];


% Initial Conditions:
u=init_problem1(x);
%u=init_problem2(x);

% store the values: 
Vals=[u];
umax=max(u(:));
% time grid: 
CFL=0.9; %CFL constant.  CFLs=[0.9,0.7,0.5]
% dt1: 0.9 ; dt2: 0.7 ; dt3: 0.5

% stability:
dt=(dx.^2)./abs(umax);
%adjust with a CFL constant. 
dt=CFL*dt;
% number of timesteps to be taken
n_it=ceil(Tmax/dt);
% temporal grid
t=(0:dt:(n_it*dt))';
time=0; % to put on the title of the plot: 


tStart=cputime;
for i=1:n_it
        
 % first node: 
    unew(1) = u(1) + dt * (epsilon*(u(2) - 2.0 * u(1) + u(N))/dx^2 ...
                    - 0.5 * ( f(u(2))- f(u(N)) )/dx);
 % interior nodes:
  unew(2:N-1) = u(2:N-1)+dt*( ...
      epsilon* (u(3:N) - 2.0 * u(2:N-1) + u(1:N-2))/dx^2 ...
      - 0.5*( f(u(3:N))- f(u(1:N-2)))/dx);
 % last node: 
    unew(N)=u(N) + dt * (epsilon*(u(1)-2.0*u(N)+u(N-1))/dx^2 ...
               - 0.5*( f(u(1))- f(u(N-1)))/dx);
   time=i*dt;
   %plot the simulation: 
   if (mod(i,100)==0 || i==n_it)
      plot(x,unew,'ob--', 'LineWidth',1,'MarkerFaceColor', 'b');
      grid on; 
      grid minor; 
      Name='Viscous Burgers with $\epsilon=0.1$ ';
      title([Name, ', t = ', num2str(floor(time+dt))], 'Interpreter','Latex');
      xlabel('$x$', 'Interpreter', 'Latex'); 
      ylabel('$u(x,t)$', 'Interpreter', 'Latex')
      pause(pausetime);
   end
           
  Vals=[Vals,unew];    
  % preparing the next node: 
  u=unew; 
  
  
end
tEnd=cputime-tStart; 

% print out the dimensions: Check the dims.
disp(size(x));
disp(size(t));
disp(size(Vals));
disp(tEnd);


figure(2)
pcolor(t,x,Vals);  
shading flat;
axis tight; 
colormap(jet);
xlabel('$t$', 'Interpreter', 'Latex'); 
ylabel('$x$', 'Interpreter', 'Latex');
axis([0 10 -8 8]);
title(['Dynamics: Numerical Methods $u_{0}(x)=-\sin(\frac{\pi x}{8})$', ', dt= ', num2str(dt)], 'Interpreter', 'Latex'); 
%title(['Dynamics: Numerical Methods $u_{0}(x)=\exp(-(x+2)^{2})$', ', dt= ', num2str(dt)], 'Interpreter', 'Latex'); 
colorbar; 


%save the result: 
% adjust dt(..) line for saving different purposes of dt. 
%save('vis_burgers_sine_dt3.mat','t','x','Vals');
%save('vis_burgers_exp_dt3.mat','t','x','Vals'); 

end


% flux function 
function value = f(u)
% evaluates the conservation quantity: 
value=0.5*u.^2; 
end 


% initial condition 1: 
function u=init_problem1(x)
    u=-sin(pi*(x./8)); 
end

% initial condition 2: 
function u=init_problem2(x)
    u=exp(-(x+2).^2);
end 

