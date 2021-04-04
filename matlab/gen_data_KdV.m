%% Korteweg-de Vries equation (two-soliton solution)
clear all; 
clc; 
format short;
nn = 100;
steps = 200;
tmax = 5;
dom = [-8 8]; x = chebfun('x',dom); tspan = linspace(0,tmax,steps+1);
S = spinop(dom, tspan);
S.lin = @(u) -1.0*diff(u,3);
S.nonlin = @(u) -1.0*0.5*diff(u.^2); % spin cannot parse "u.*diff(u)"
%S.init = -sin(pi*x/8);
S.init = cos(-pi*x/8);
u = spin(S,nn,1e-4);

usol = zeros(nn,steps+1);
for i = 1:201
    usol(:,i) = u{i}.values;
end

x = linspace(-8,8,nn+1);
x = x(1:end-1);
t = tspan;
figure(2)
pcolor(t,x,usol); shading interp, axis tight, colormap(jet);
xlabel('$t$', 'Interpreter', 'Latex'); 
ylabel('$x$', 'Interpreter', 'Latex');
colorbar; 
%title('Exact Dynamics with $u_{0}(x) = - \sin(\frac{\pi x}{8})$', 'Interpreter', 'Latex'); 
title('Exact Dynamics with $u_{0}(x) = \cos( \frac{-\pi x}{8}) $', 'Interpreter', 'Latex'); 

%save('kdV_sine.mat','t','x','usol')
save('kdV_cosine.mat','t','x','usol')




