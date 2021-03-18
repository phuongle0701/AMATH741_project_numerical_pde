%% Korteweg-de Vries equation (two-soliton solution)
nn = 512;
steps = 200;

dom = [-20 20]; x = chebfun('x',dom); 
tspan = linspace(0,40,steps+1);
S = spinop(dom, tspan);
S.lin = @(u) -1.0*diff(u,3);
S.nonlin = @(u) -1.0*0.5*diff(u.^2); % spin cannot parse "u.*diff(u)"
%S.init = -sin(pi*x/20);
S.init = cos(-1*(pi*x/20)); 
u = spin(S,nn,1e-4);

usol = zeros(nn,steps+1);
for i = 1:201
    usol(:,i) = u{i}.values;
end

x = linspace(-20,20,nn+1);
x = x(1:end-1);
t = tspan;
figure(2); 
pcolor(t,x,usol); 
shading interp; 
axis tight; 
colormap(jet);
xlabel('$t$', 'Interpreter', 'Latex'); 
ylabel('$x$', 'Interpreter', 'Latex');
colorbar; 
%title('Exact Dynamics with $u_{0}(x) = - \sin(\frac{\pi x}{20})$', 'Interpreter', 'Latex'); 
title('Exact Dynamics with $u_{0}(x) = \cos(\frac{-\pi x}{20})$', 'Interpreter', 'Latex'); 

% save the result: 
%save('KdV_sine.mat','t','x','usol')
save('kdV_cosine.mat', 't', 'x', 'usol'); 