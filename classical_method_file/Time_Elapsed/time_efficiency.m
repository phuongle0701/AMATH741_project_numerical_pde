function time_efficiency
clear all; 
clc; 

% Inviscid Burgers: 
a=-8;
b=8;
TimeElapsed_IC1=[4.8571, 6.2184, 10.0944, 17.9028, 34.1976];
TimeElapsed_IC2=[4.1401, 6.1931, 15.3009, 18.2261, 34.1848];
Nsize=[50,100,200,400,800]; 
xsize=zeros(size(Nsize));
    for iter=1:length(Nsize)
        xsize(iter)=grid_size(a,b,Nsize(iter));
    end
xsize=fliplr(xsize);
TimeElapsed_IC1=fliplr(TimeElapsed_IC1); 
TimeElapsed_IC2=fliplr(TimeElapsed_IC2);
figure(1)
    plot(log2(xsize),TimeElapsed_IC1,'o-.', 'MarkerFaceColor', 'red','MarkerEdgeColor','red', 'LineWidth', 4); 
    hold on; 
    plot(log2(xsize),TimeElapsed_IC2,  's--', 'MarkerFaceColor', 'blue','MarkerEdgeColor','blue', 'LineWidth',4); 
    hold off; 
    legend({'First Initial Condition','Second Initial Condition'}, 'Interpreter', 'Latex', 'Location','best');
    xlabel('$\Delta x$ size', 'Interpreter', 'Latex'); 
    ylabel('Time-Execution $sec.$', 'Interpreter', 'Latex');
    title('Time Execution: Inviscid Burgers','Interpreter','Latex');
    grid on; 
    grid minor;  
    set (gca, 'XTickLabel', strcat('2^{',num2str(log2(xsize(:) )),'}'))
    
    
% Viscous Burgers: 
a=-8; 
b=8; 
TimeElapsed_IC1=[1.165, 7.3381, 36.3216, 77.235];
TimeElapsed_IC2=[3.3822, 6.7546, 31.7804, 85.8735];
Nsize=[256,512,1024,2048]; 
xsize=zeros(size(Nsize));
    for iter=1:length(Nsize)
        xsize(iter)=grid_size(a,b,Nsize(iter));
    end
xsize=fliplr(xsize);
TimeElapsed_IC1=fliplr(TimeElapsed_IC1); 
TimeElapsed_IC2=fliplr(TimeElapsed_IC2);
figure(2)
    plot(log2(xsize),TimeElapsed_IC1,'o-.', 'MarkerFaceColor', 'red','MarkerEdgeColor','red', 'LineWidth', 4); 
    hold on; 
    plot(log2(xsize),TimeElapsed_IC2,  's--', 'MarkerFaceColor', 'blue','MarkerEdgeColor','blue', 'LineWidth',4); 
    hold off; 
    legend({'First Initial Condition','Second Initial Condition'}, 'Interpreter', 'Latex', 'Location','best');
    xlabel('$\Delta x$ size', 'Interpreter', 'Latex'); 
    ylabel('Time-Execution $sec.$', 'Interpreter', 'Latex');
    title('Time Execution: Viscous Burgers','Interpreter','Latex');
    grid on; 
    grid minor; 
    set (gca, 'XTickLabel', strcat('2^{',num2str(log2(xsize(:) )),'}'))

    
% kdV equation: 

a=-8;
b=8;
TimeElapsed_IC1=[0.71544, 3.8649, 20.7044,86.9945];
TimeElapsed_IC2=[0.61018, 1.9018, 11.0901, 94.7918];
Nsize=[50,100,200,400]; 
xsize=zeros(size(Nsize));
    for iter=1:length(Nsize)
        xsize(iter)=grid_size(a,b,Nsize(iter));
    end
xsize=fliplr(xsize);
TimeElapsed_IC1=fliplr(TimeElapsed_IC1); 
TimeElapsed_IC2=fliplr(TimeElapsed_IC2);
figure(3)
    plot(log2(xsize),TimeElapsed_IC1,'o-.', 'MarkerFaceColor', 'red','MarkerEdgeColor','red', 'LineWidth', 4); 
    hold on; 
    plot(log2(xsize),TimeElapsed_IC2,  's--', 'MarkerFaceColor', 'blue','MarkerEdgeColor','blue', 'LineWidth',4); 
    hold off; 
    legend({'First Initial Condition','Second Initial Condition'}, 'Interpreter', 'Latex', 'Location','best');
    xlabel('$\Delta x$ size', 'Interpreter', 'Latex'); 
    ylabel('Time-Execution $sec.$', 'Interpreter', 'Latex');
    title('Time Execution: kdV Equation','Interpreter','Latex');
    grid on; 
    grid minor;  
    set (gca, 'XTickLabel', strcat('2^{',num2str(log2(xsize(:) )),'}'))
    
end 

% function that computes the grid size in each problem
function xsize = grid_size(a,b,N)
xsize = (b-a)./N; 
end