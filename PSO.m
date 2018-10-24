% draw picture
close all;
clear
clc
tic;
theta = 0 : pi/200 : 2*pi;
a = 2*cos(theta);
b = 2*sin(theta);
plot(a,b,'k');
grid on;
hold on;
plot(1,-4,'r*')
% initial index
w = 0.9;
c1 = 2;
c2 = 2;
popsize = 5;
% max step
max_step = 20;
%initial population
x1=rand(popsize,1)*4-2;
temp=sqrt(4-x1.^2);
x2 = 2.*temp.*rand(popsize,1) - temp;
plot(x1,x2,'o');
%initial pbest & gbest & velocity
pbest1 = rand(popsize,1)*4-2;
pbest2 = 2 .* sqrt(4-x1.^2) .* rand(popsize,1) - sqrt(4-x1.^2);
v1 = rand(popsize,1);
v2 = rand(popsize,1);
gbest1 = pbest1;
gbest2 = pbest2;

% count variable
count = 0;
y = (x1-1).*(x1-1)+(x2+4).*(x2+4);
f = (pbest1 - 1).^2 + (pbest2 + 4).^2;
pro_f = y;
while count < max_step
    count=count+1;
    w = max(w - (count/max_step)*w,0.4);
    % update x1 & x2 & velocity 
    v1 = w .* v1 + c1.*rand(popsize,1).*(pbest1 - x1) + c2 .* rand(popsize,1).*(gbest1 - x1);
    v2 = w .* v2 + c1.*rand(popsize,1).*(pbest2 - x2) + c2 .* rand(popsize,1).*(gbest2 - x2);
    x1 = max(-2,min(x1 + v1 , 2));
    bound = sqrt(4-x1.^2);
    x2 = max(-bound , min(x2 + v2 , bound));
    % computing cost function
    f = (x1 - 1).^2 + (x2 + 4).^2;
    % find pbest1 & pbest2
    for i = 1:1:popsize
        if(f(i) < pro_f)
            pbest1(i) = x1(i);
            pbest2(i) = x2(i); 
        end
    end
    pro_f = f;
    % update gbest 
   num = find(f==min(f));
   gbest1 = pbest1(num(1));
   gbest2 = pbest2(num(1));
   repmat(gbest1,popsize,1);
   repmat(gbest2,popsize,1);
   plot(pbest1,pbest2,'+','markeredgecolor','m');
   plot(gbest1,gbest2,'s','markeredgecolor','b');
   hold on;
   pause(0.1);
   
   % judge stop condition
%    if abs(pro_f - f) < 0.001
%        break;
%    else
%        pro_f = f;
%    end
end
X = gbest1;
Y = gbest2;
plot(X,Y,'*','markeredgecolor','r');
[X,Y]
min(f)
toc;
disp(['运行时间: ',num2str(toc)]);