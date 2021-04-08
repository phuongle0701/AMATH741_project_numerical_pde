% Inviscid Burgers Equation: 
function burgers 
clc; 
close all; 
clear all; 
format short; 
N=100;% number of grid cells. 
% domain of our solution (x,t) in [-8,8]x[0,2]
xmax=8;
xmin=-8; 
tmin=0;
tmax=2; 
dx = (xmax-xmin)/N; 
% domain 
x=(xmin-dx:dx:xmax+dx); 

%storage of value:
u=zeros(size(x));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Change the values here to simulate the appropriate problem:
% Time to end: 
Tmax=2; 
pausetime = 0.00001; % pausetime between simulation. 
%%%%%%%%%%%%Problem 1 %%%%%%%%%%%%%%%%
Name = 'With $u_{0}(x) = -\sin(\pi \frac{x}{8})$';  
u = init_problem1(x);

%%%%%%%%%%% Problem 2 %%%%%%%%%%%%%%%%
%Name = '$u_{0}(x) = \cos(-\pi \frac{x}{8})$'; 
%u = init_problem2(x);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Store the value snapshots: 
Vals=[];
Vals=[u(2:N+1)'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Vectors for circular shifting: 
shiftp1 = circshift((1:length(x))',1);
shiftm1 = circshift((1:length(x))',-1);




%time space: 
umax=max(u); % maximum value of the solution. 
CFL=0.4; %CFL constant 
% adjust with CFL = [0.4,0.3,0.2] (0.4: dt1, 0.3: dt2, 0.2: dt3);
dt=(CFL).*(dx)./abs(umax); 

tplot=[0.5,2.0];
t = 0;
it = 1; 
itercount=0;


%Boundary conditions: 
% We set the ghost cell values to the closet values of regular cells. 
u(1)=u(2); 
u(N+2)=u(N+1);

% measuring the efficiency: 
tic(); 
while (t<Tmax)
    uold = u; told = t; t = t + dt; itercount=itercount+1;
     % store the snapshots: 
    
   
    % Compute the lambda value: 
    fpl =uold(shiftp1); 
    fpr =uold; 
    lambda = norm([abs(fpl(:)) abs(fpr(:))], Inf);
    
    % calculate (f(u) = u^2/2): 
    fu = 0.5*uold.^2; 
  
    % calculate the flux: 
    flux = 0.5*(fu + fu(shiftm1)) - ...
        0.5*bsxfun(@times, uold(shiftm1) - uold, lambda); 
    
   % Updating Values:
   stepsize = (dt/dx); 
   u = uold - (stepsize)*(flux - flux(shiftp1)); 
   
   % impose boundary conditions: 
   u(1) = u(2);
   u(N+2)=u(N+1);
   
      % adjust the time  
  % if (it<=length(tplot) && tplot(it)>=told && tplot(it)<=t+dt)
  %      dt = tplot(it)-t;
  %      it = it + 1;
  % end
   
   
  
   % plotting: 
   uplot = u(2:N+1);
   xplot = x(2:N+1);
   plot(xplot, uplot,'xb-.', 'LineWidth',2,'MarkerFaceColor', 'b')
   xlabel('$x(t)$', 'Interpreter','Latex');
   ylabel('$u(x,t)$', 'Interpreter', 'Latex');
   axis([-8 8 -1.5 1.5]); 
   title([Name, ', t = ', num2str(floor(t))], 'Interpreter','Latex');
   legend('Local Lax-Friedrichs');
   grid on; 
   grid minor; 
   pause(pausetime); 
   
   Vals=[Vals, uplot'];
end 
disp(['Time to execute: ', num2str(toc())]);
disp(['Time step: ', num2str(dt)]);

x=x(2:N+1);
disp(size(Vals));
t=0:dt:(Tmax+dt);
disp(size(x));
disp(size(t));



% DYNAMICS PLOT 

figure(2); 
pcolor(t,x,Vals);  
shading flat; 
axis tight; 
colormap(jet);
xlabel('$t$', 'Interpreter', 'Latex'); 
ylabel('$x$', 'Interpreter', 'Latex');
axis([0 2 -8 8]);
title(['Dynamics: Numerical Methods $u_{0}(x)=-\sin(\frac{\pi x}{8})$', ', dt= ', num2str(dt)], 'Interpreter', 'Latex'); 
%title(['Dynamics: Numerical Methods $u_{0}(x)=\cos(-\frac{\pi x}{8})$', ', dt= ', num2str(dt)], 'Interpreter', 'Latex'); 
colorbar; 



% Save the result 
% adjust dt1 line for saving different 
%save('inv_burgers_sine_dt1.mat','t','x','Vals');
%save('inv_burgers_cosine_dt1.mat','t','x','Vals'); 


end


% function to asign values to initial condition in problem 1. 
function [u] = init_problem1(x)
u = -sin(pi*(x./8)); 
end
% function to assign values to initial condition in problem 2: 
function [u]=init_problem2(x)
u=cos(-pi*(x./8)); 
end

