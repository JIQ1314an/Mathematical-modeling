close all
clear
% 1. 加载数据
data = xlsread('original_data.xlsx');
x = data(:,3:end);%Xi因子矩阵
n = length(x);
X = [ones(n,1),x];%产生一个n行一列的矩阵，后接x矩阵,假设起始残差为1
y = data(:,2);
% 2. 绘制散点图
x1 = x(:,1);
x2 = x(:,2);
x3 = x(:,3);
draw_scatter3(x1,x2,x3,y,'真实值与变量因子的散点图')
% 3. 求解相关系数及指标 
[b,bint,r,rint,stats] = regress(y,X);%alpha：显著性水平（缺少时为默认值0.05）
% 4. 打印函数表达式
fprintf('y = %f + %f x1 + %f x2 - %f x3 \n\n',b(1),b(2),b(3),-b(4));
% 5. 绘制曲线
z =  b(1) + b(2)*x1 + b(3)*x2 +  b(4)*x3;
draw_scatter3(x1,x2,x3,z,'预测值与变量因子的散点图')
stats

function [] = draw_scatter3(x,y,z,c,label)
figure, scatter3(x,y,z,40,c,'filled')    % draw the scatter plot

view(-31,14)
xlabel('x1')
ylabel('x2')
zlabel('x3')

cb = colorbar;                                     % create and label the colorbar
cb.Label.String = label;
end