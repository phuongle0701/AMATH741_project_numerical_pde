%% Burgers equation and chaos
nn = 256;
steps = 200;

dom = [-8 8]; x = chebfun('x',dom); tspan = linspace(0,10,steps+1);
S = spinop(dom, tspan);
S.lin = @(u) + 0.1*diff(u,2);
S.nonlin = @(u) - 0.5*diff(u.^2); % spin cannot parse "u.*diff(u)"
%S.init = -sin(pi*x/8);
S.init = exp(-1*(x + 2).^2); 
u = spin(S,nn,1e-4);

usol = zeros(nn,steps+1);
for i = 1:steps+1
    usol(:,i) = u{i}.values;
end

x = linspace(-8,8,nn+1);
x = x(1:end-1);
t = tspan;
figure(2); 
pcolor(t,x,real(usol)); 
shading interp; 
axis tight; 
colormap(jet);
xlabel('$t$', 'Interpreter', 'Latex'); 
ylabel('$x$', 'Interpreter', 'Latex');
%title('Exact Dynamics with $u_{0}(x) = - \sin(\frac{\pi x}{8})$', 'Interpreter', 'Latex'); 
title('Exact Dynamics with $u_{0}(x) = \exp(-(x+2)^{2})$', 'Interpreter', 'Latex'); 
colorbar; 

% save the result: 
%save('burgers_sine.mat','t','x','usol');
save('burgers_exp.mat', 't', 'x', 'usol'); 

