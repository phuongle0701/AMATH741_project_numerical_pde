function kdV
    clc; 
    close all; 
    clear all; 
    format short;
    % first initialize some parameters  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    xmin = -8;
    xmax = 8;
    %spatial step
    N=100;
    % number of grid points in space (not counting the point at x=1, which
    % is the same as the point at x=0, due to the periodicity)
    h=(xmax - xmin)/N;
    % methods: Zabusky-Kruskal. 
    % time at which we want to end the simulation
    Tmax = 5.0;
    pausetime=0.000001;
    % initialize some arrays
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    v_new=zeros(N,1);
    v_old=zeros(N,1);
    % spatial grid (not including the point at x=1, which is the same at
    % the point at x=0, due to the periodicity)
    x=(xmin:h:xmax-h)';
    
    % initialize the value: 
    v_old=init_problem1(x);
    %v_old=init_problem2(x);
    v_older = v_old;
    % Store the value:
    Vals=[];
    Vals=[v_old];
    umax=max(v_old);
    CFL=0.9; % CFL = 0.9,0.8,0.7. dt1: 0.9; dt2: 0.8; dt3=0.7. 
    
    % Stability: 
    dt=(2*h)/((3*sqrt(3))*abs(-2*umax + (1/(h*h)))); 
    dt=CFL*dt; 
    
    % number of timesteps to be taken
    n_it=floor(Tmax/dt);
    % temporal grid
    t=(0:dt:n_it*dt)';
    
    for iter=1:n_it
        
        if iter==1
            v_new(3:N-2,1) = v_old(3:N-2,1) - dt/h*(v_old(2:N-3,1) + ...
                v_old(3:N-2,1) + v_old(4:N-1,1)) .*(v_old(4:N-1,1) - v_old(2:N-3,1))...
                - dt/(2*h^3)*(v_old(5:N,1) - 2*v_old(4:N-1,1) + 2*v_old(2:N-3,1) -...
                v_old(1:N-4,1));
        else 
            v_new(3:N-2,1) = v_older(3:N-2,1) - (dt/(3*h))*(v_old(2:N-3,1) + ...
                v_old(3:N-2,1) + v_old(4:N-1,1)) .*(v_old(4:N-1,1) - v_old(2:N-3,1))...
                - dt/h^3*(v_old(5:N,1) - 2*v_old(4:N-1,1) + 2*v_old(2:N-3,1) -...
                v_old(1:N-4,1));
        end    
        
        v_new(2,1) = v_older(2,1) - (dt/3*h)*(v_old(1,1) + v_old(2,1) + ...
            v_old(3,1)) .* (v_old(3,1) - v_old(1,1)) - (dt./(h^3))*(v_old(4,1) - ...
            2*v_old(3,1) + 2*v_old(1,1) - v_old(N,1));
        v_new(N-1,1) = v_older(N-1,1) - (dt/3*h)*(v_old(N-2,1) + v_old(N-1,1) + ...
            v_old(N,1)) .* (v_old(N,1) - v_old(N-2,1)) - (dt./(h^3))*(v_old(1,1) -...
            2*v_old(N,1) + 2*v_old(N-2,1) - v_old(N-3,1));
        v_new(1,1) = v_older(1,1) - (dt/3*h)*(v_old(N,1) + v_old(1,1) + ...
            v_old(2,1)) .* (v_old(2,1) - v_old(N,1)) - (dt./(h^3))*(v_old(3,1) - ...
            2*v_old(2,1) + 2*v_old(N,1) - v_old(N-1,1));
        v_new(N,1) = v_older(N,1) - (dt/3*h)*(v_old(N-1,1) + v_old(N,1) + ...
            v_old(1,1)) .* (v_old(1,1) - v_old(N-1,1)) - (dt./(h^3))*(v_old(2,1) - ...
            2*v_old(1,1) + 2*v_old(N-1,1) - v_old(N-2,1));
        
           t=iter*dt;
          if (mod(iter, 100) == 0 || iter==n_it)
              plot(x,v_new(:,1),'sr-.', 'LineWidth',2,'MarkerFaceColor', 'r')
              grid on;
              grid minor;
              Name='Zabusky-Kruskal '; 
              title([Name, ', t = ', num2str(t+dt)], 'Interpreter','Latex');
              xlabel('$x$', 'Interpreter', 'Latex'); 
              ylabel('$u(x,t)$', 'Interpreter', 'Latex')
              pause(pausetime);
          end
          
         % prepare for the next iteration
        Vals=[Vals,v_new];
        v_older=v_old;
        v_old=v_new;  
    end
    disp(size(Vals));
    xval=x';
    disp(size(xval));
    time=linspace(0,Tmax,n_it+1);
    disp(size(time));
    
figure(2); 
pcolor(time,xval,Vals);  
shading flat; 
axis tight; 
colormap(jet);
xlabel('$t$', 'Interpreter', 'Latex'); 
ylabel('$x$', 'Interpreter', 'Latex');
axis([0 5 -8 8]);
title(['Dynamics: Numerical Methods $u_{0}(x)=-\sin(\frac{\pi x}{8})$', ', dt= ', num2str(dt)], 'Interpreter', 'Latex'); 
%title(['Dynamics: Numerical Methods $u_{0}(x)=\cos(-\frac{\pi x}{8})$', ', dt= ', num2str(dt)], 'Interpreter', 'Latex'); 
colorbar; 

% Save the result 
% adjust dt line for saving different dt values
%save('kdV_sine_dt1.mat','time','xval','Vals');
%save('kdV_cosine_dt1.mat','time','xval','Vals'); 



end

% function to asign values to initial condition in problem 1. 
function [u] = init_problem1(x)
u = -sin(pi*(x./8)); 
end
% function to assign values to initial condition in problem 2: 
function [u]=init_problem2(x)
u=cos(-pi*(x./8)); 
end
 