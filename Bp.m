%权重和偏置
w1=0.15;
w2=0.2;
w3=0.25;
w4=0.3;
w5=0.4;
w6=0.45;
w7=0.5;
w8=0.55;

p3=0.35;
p4=0.35;
p5=0.6;
p6=0.6;
%样本
x=[0.05,0.1];
%输出
o=[0 0 0 0 0 0];
output4=[1:0:99];
output5=[1:0:99];
output6=[1:0:99];
output6=[1:0:99];

s3=0;
s4=0;
s5=0;
s6=0;
%误差
error=[0 0 0 0 0 0];
ERR5=[1:0:99];
ERR6=[1:0:99];
%学习率
l = 0.9;
%迭代次数变量
count = 0;
%求输出层输出
for i = 1:2
   o(i)=x(i);
end
%控制循环次数 或者可以控制输出误差
while(count < 200)
%求每一层的输出
s3 = w1*o(1) + w2*o(2) + p3;
s4 = w3*o(1) + w4*o(2) + p4;

o(3) = 1/(1+1/exp(s3));
o(4) = 1/(1+1/exp(s4));

s5 = w5*o(3) + w6*o(4) + p5;
s6 = w7*o(3) + w8*o(4) + p6;

o(5) = 1/(1+1/exp(s5));
o(6) = 1/(1+1/exp(s6));
%求每个神经元的误差
error(6)= o(6)*(1-o(6))*(1-o(6));
error(5)= -o(5)*(1-o(5))*o(5);
ERR6(count+1) = error(6);
ERR5(count+1) = error(5);

error(3)= o(3)*(1-o(3))*(error(5)*w5 + error(6)*w7);
error(4)= o(4)*(1-o(4))*(error(5)*w6 + error(6)*w8);
%更新权值
w1 = w1 + l*o(1)*error(3);
w2 = w2 + l*o(2)*error(3);
w3 = w3 + l*o(1)*error(4);
w4 = w4 + l*o(2)*error(4);
w5 = w5 + l*o(3)*error(5);
w6 = w6 + l*o(4)*error(5);
w7 = w7 + l*o(3)*error(6);
w8 = w8 + l*o(4)*error(6);

p6 = p6 + l * error(6);
p5 = p5 + l * error(5);
p4 = p4 + l * error(4);
p3 = p3 + l * error(3);

output3(count+1) = o(3);
output4(count+1) = o(4);
output5(count+1) = o(5);
output6(count+1) = o(6);
count = count +1;
end
subplot(2,2,1)
plot(output5,'r*-');
title('5号神经元输出');
subplot(2,2,2)
plot(output6,'r*-');
title('6号神经元输出');
subplot(2,2,3)
plot(ERR5,'b*-');
title('5号神经元误差');
subplot(2,2,4)
plot(ERR6,'b*-')
title('6号神经元误差');