clear
clc
cd /home/siddharth/FOSSEE-Optimization-toolbox
exec cleaner.sce;
ulink;

exec builder.sce;
exec("loader.sce");

//Example 4:
//Objective function to be minimised
function [y, dy]=f(x, lambda)
y=x(1)*x(2)+x(2)*x(3);
dy= [x(2),x(1)+x(3),x(2)];

endfunction
//Starting point, linear constraints and variable bounds
x0=[0.1 , 0.1 , 0.1];
intcon = [2]
A=[];
b=[];
Aeq=[];
beq=[];
lb=[];
ub=[];
//Nonlinear constraints
function [c, ceq, cg, cgeq]=nlc(x)
c = [x(1)^2 - x(2)^2 + x(3)^2 - 2 , x(1)^2 + x(2)^2 + x(3)^2 - 10];
ceq = [];
cg=[2*x(1) , -2*x(2) , 2*x(3) ; 2*x(1) , 2*x(2) , 2*x(3)];
cgeq=[];
endfunction

function y=lHess(x, obj, lambda)
    y= obj*[0,1,0;1,0,1;0,1,0] + lambda(1)*[2,0,0;0,-2,0;0,0,2] + lambda(2)*[2,0,0;0,2,0;0,0,2]
    disp("lHess")
    disp(x)
    disp(y)

endfunction

//Options
options=list("MaxIter", [1500], "CpuTime", [500], "GradObj", "on","GradCon", "on", "hessian", lHess);
//Calling Ipopt
[x,fval,exitflag,output] =intfmincon(f, x0,intcon,A,b,Aeq,beq,lb,ub,nlc,options)
// Press ENTER to continue

