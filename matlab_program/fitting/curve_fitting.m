clc
clear
% 1. 加载数据
d=300;
t = [0.25 0.5 1 1.5 2 3 4 6 8];
c = [19.21 18.15 15.36 14.10 12.89 9.32 7.45 5.24 3.01];
% 2. 绘制散点图
plot(t, c, 'r*', 'MarkerSize', 5);  %可以利用从c(t)=c0*e^-kt拟合(c0,k为待定系数）
hold on
y=log(c);
a=polyfit(t,y,1) %“1”表示一个未知变量
k=-a(1)
v=d/exp(a(2))
t = 0.25:0.25:8;
c = (d/v)*exp(-k*t);
fprintf("函数表达式：c(t) = %.4fe^(-%.4ft)\n\n",d/v,k);
plot(t, c, 'g');