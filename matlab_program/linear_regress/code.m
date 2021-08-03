clc;
clear;
% 1. 加载数据
data = load('data.txt');
x = data(1,:)';%参数矩阵
X = [ones(6,1),x];%产生一个6行一列的矩阵，后接x矩阵,假设起始残差为1
y = data(2,:)';
% 2. 绘制散点图
plot(x, y, 'r*', 'MarkerSize', 5); % 5控制*的大小
hold on
% 3. 求解相关系数及指标 
[b,bint,r,rint,stats] = regress(y,X);
% 4. 绘制曲线
z =  b(1) + b(2)*x;
fprintf('y = %f x + %f \n',b(2),b(1));
plot(x, z, 'g');
% 5. 相关统计
b;
stats
% 6. 进行预测
x0 = input('请输入第x年：');
z0 = b(1) + b(2) * x0;
fprintf('预测第%d年的用电量%.1f \n',x0,z0);