% Inviscid Burgers equation 
nn = 100;
steps = 200;
tmax = 2.0; 
xmax = 8; 
xmin = -8; 
dom = [xmin xmax]; x = chebfun('x',dom); tspan = linspace(0,tmax,steps+1);
S = spinop(dom, tspan);
S.lin = @(u) + 0.0*diff(u,2);
S.nonlin = @(u) - 0.5*diff(u.^2); % spin cannot parse "u.*diff(u)"
% initial profile. 
%S.init = -sin(pi*x/8);
S.init = cos(-pi*x/8);  

% solver: 
u = spin(S,nn,1e-4);
usol = zeros(nn,steps+1);
for i = 1:steps+1
    usol(:,i) = u{i}.values;
end

x = linspace(xmin,xmax,nn+1);
x = x(1:end-1);
disp(size(x));
t = tspan;
figure(2); 
pcolor(t,x,real(usol)); 
%surf(t,x,real(usol)); 
shading interp; 
axis tight; 
colormap(jet);
xlabel('$t$', 'Interpreter', 'Latex'); 
ylabel('$x$', 'Interpreter', 'Latex');
%title('Exact Dynamics of Inviscid Burgers with $u_0 = -\sin(\frac{\pi x}{8})$', 'Interpreter', 'Latex'); 
title('Exact Dynamics of Inviscid Burgers with $u_0 = \cos(-\frac{\pi x}{8})$', 'Interpreter', 'Latex');
colorbar; 
% save the result: 
%save('inv_burgers_sine.mat','t','x','usol');
save('inv_burgers_cosine.mat','t','x','usol');
