function error_analysis_inv_burgers
clc;
clear all; 
format short; 
dt=[0.064,0.048,0.032]'; 

disp(['Relative Error for Sine initial condition'])

%load the data: sine initial condition.
truth=load('inv_burgers_sine','-mat');
approx1=load('inv_burgers_sine_dt1','-mat');
approx2=load('inv_burgers_sine_dt2','-mat');
approx3=load('inv_burgers_sine_dt3','-mat');

ValTruth=truth.usol; 
Val1=approx1.Vals;
Val2=approx2.Vals;
Val3=approx3.Vals;

t_truth=truth.t;
t1=approx1.t; 
t2=approx2.t;
t3=approx3.t;


%We check at T = 2.00:

Tval=2.0;
disp(['At T = ', num2str(Tval)]);
Rel_Err2_T2=Comp_RelL2(ValTruth, Val1,Val2,Val3,Tval,t_truth,t1,t2,t3);
T=table(dt, Rel_Err2_T2);
T.Properties.VariableNames={'dt', 'Relative_ErrorL2'}; 
disp(T);

%We check at T=1.99 

Tval=1.99;
disp(['At T = ', num2str(Tval)]);
Rel_Err2_T199=Comp_RelL2(ValTruth, Val1,Val2,Val3,Tval,t_truth,t1,t2,t3);
T=table(dt, Rel_Err2_T199);
T.Properties.VariableNames={'dt', 'Relative_ErrorL2'}; 
disp(T);

% We check at T = 1.00

Tval=1.0;
disp(['At T = ', num2str(Tval)]);
Rel_Err2_T1=Comp_RelL2(ValTruth, Val1,Val2,Val3,Tval,t_truth,t1,t2,t3);
T=table(dt, Rel_Err2_T1);
T.Properties.VariableNames={'dt', 'Relative_ErrorL2'}; 
disp(T);

% We check at T=0.5

Tval=0.5;
disp(['At T = ', num2str(Tval)]);
Rel_Err2_T05=Comp_RelL2(ValTruth, Val1,Val2,Val3,Tval,t_truth,t1,t2,t3);
T=table(dt, Rel_Err2_T05);
T.Properties.VariableNames={'dt', 'Relative_ErrorL2'}; 
disp(T);




disp(['Relative Error for Coine initial condition'])

%load the data: sine initial condition.
truth=load('inv_burgers_cosine','-mat');
approx1=load('inv_burgers_cosine_dt1','-mat');
approx2=load('inv_burgers_cosine_dt2','-mat');
approx3=load('inv_burgers_cosine_dt3','-mat');

ValTruth=truth.usol; 
Val1=approx1.Vals;
Val2=approx2.Vals;
Val3=approx3.Vals;

t_truth=truth.t;
t1=approx1.t; 
t2=approx2.t;
t3=approx3.t;


%We check at T = 2.00:

Tval=2.0;
disp(['At T = ', num2str(Tval)]);
Rel_Err2_T2=Comp_RelL2(ValTruth, Val1,Val2,Val3,Tval,t_truth,t1,t2,t3);
T=table(dt, Rel_Err2_T2);
T.Properties.VariableNames={'dt', 'Relative_ErrorL2'}; 
disp(T);

%We check at T=1.99 

Tval=1.99;
disp(['At T = ', num2str(Tval)]);
Rel_Err2_T199=Comp_RelL2(ValTruth, Val1,Val2,Val3,Tval,t_truth,t1,t2,t3);
T=table(dt, Rel_Err2_T199);
T.Properties.VariableNames={'dt', 'Relative_ErrorL2'}; 
disp(T);

% We check at T = 1.00

Tval=1.0;
disp(['At T = ', num2str(Tval)]);
Rel_Err2_T1=Comp_RelL2(ValTruth, Val1,Val2,Val3,Tval,t_truth,t1,t2,t3);
T=table(dt, Rel_Err2_T1);
T.Properties.VariableNames={'dt', 'Relative_ErrorL2'}; 
disp(T);

% We check at T=0.5

Tval=0.5;
disp(['At T = ', num2str(Tval)]);
Rel_Err2_T05=Comp_RelL2(ValTruth, Val1,Val2,Val3,Tval,t_truth,t1,t2,t3);
T=table(dt, Rel_Err2_T05);
T.Properties.VariableNames={'dt', 'Relative_ErrorL2'}; 
disp(T);

end


function Rel_Err2=RelativeErrorL2(truth,value)
diff=(sum(abs(truth-value).^2)).^(1/2);
normTruth=norm(truth,2);
Rel_Err2=diff/normTruth; 
end


% locate the index for a given T set and Tvalue we want to find
function [index]=locate_index(T, Tval)
    niter=length(T); 
    tol=1e-2; 
    for i=1:niter
        % extract the value: 
        Tcheck=T(i); 
       if (Tcheck-Tval<tol)
            index=i;
       end
    end
end

% function to compute the Relative Error L2 at specific Tval: 
% return the relative error L2 set: (1): dt1 (2): dt2 (3):dt3.
function [rel_errL2]=Comp_RelL2(ValTruth, Val1, Val2, Val3, Tval, t_truth, t1,t2,t3)
index=locate_index(t_truth,Tval);
indx1=locate_index(t1,Tval);
indx2=locate_index(t2,Tval);
indx3=locate_index(t3,Tval);

rel_errL2=zeros(3,1);
ValTruth=ValTruth(:,index); 
Val1=Val1(:,indx1);
Val2=Val2(:,indx2);
Val3=Val3(:,indx3);

rel_errL2(1)=RelativeErrorL2(ValTruth,Val1);
rel_errL2(2)=RelativeErrorL2(ValTruth,Val2);
rel_errL2(3)=RelativeErrorL2(ValTruth,Val3);
end




