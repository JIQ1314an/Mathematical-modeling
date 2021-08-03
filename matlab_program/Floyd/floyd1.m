clc
clear
W = ones(6) * inf; %权矩阵初始化
for i = 1:6
    W(i,i) = 0;
end

W(1,2) = 2; W(1,3) = 7;
W(2,1) = 2; W(2,3) = 4; W(2,5) = 8; W(2,4) = 6;
W(3,1) = 7; W(3,2) = 4; W(3,4) = 1; W(3,5) = 5; W(3,5) = 3;
W(4,2) = 6; W(4,3) = 1; W(4,5) = 1; W(4,6) = 6;
W(5,2) = 8; W(5,3) = 3; W(5,4) = 1; W(5,6) = 3;
W(6,4) = 6; W(6,5) = 3; %修改元素后W为权矩阵

pre_path = {'v1', 'v2', 'v3', 'v4', 'v5', 'v6'}; %本例中网络图结点
 
start = 1; %起始节点为v1
stop = 6; %终止结点为v6

[D, P, dis, path] = Floyd(W, start, stop); %调用函数求解
fprintf('\n最短距离矩阵 D =\n\n')
disp(D)
fprintf('\n路由矩阵 P =\n\n')
disp(P)
% fprintf('结点%s到%s的最短距离为:%f\n\n', pre_path{start}, pre_path{stop}, dis)
% fprintf('结点%s到%s的最短路径为:\n\n', pre_path{start}, pre_path{stop})%输出两给定结点间的最短路径
% 
% for i = 1:length(path)-1
%     fprintf('%s', pre_path{path(i)})
%     fprintf(' -> ')
% end
% fprintf('%s.\n', pre_path{path(length(path))})

% 求解学生上学的总路程
fprintf('\n学生上学来往各村庄的总路程 S =\n\n')
S = D;
S(1,:) = S(1,:) * 50;
S(2,:) = S(2,:) * 40;
S(3,:) = S(3,:) * 60;
S(4,:) = S(4,:) * 20;
S(5,:) = S(5,:) * 70;
S(6,:) = S(6,:) * 90;
disp(S)
%学校（终点）为v时的总路径--->每列相加
sum_result = sum(S)
index = find(sum_result == min(sum_result));
fprintf('\n小学建 "v%d" 村庄，使得所有学生上学走的总路程最短\n\n', index)

%% Function:输出网络图的最短距离矩阵和路由矩阵，指定两结点间的最短距离及其路径
function [D, P, dis, path] = Floyd(W, start, stop) %start为指定起始结点，stop为指定终止结点
D = W; %最短距离矩阵赋初值
n = length(D); %n为结点个数
P = zeros(n,n); %路由矩阵赋初值

for i = 1:n
    for j = 1:n
        P(i,j) = j;
    end
end

for k = 1:n
    for i = 1:n
        for j = 1:n
            if D(i,k) + D(k,j) < D(i,j)
                D(i,j) = D(i,k) + D(k,j);   %核心代码
                P(i,j) = P(i,k);
            end
        end
    end
end
                  
if nargin ~= 3
    errordlg('参数个数输入有误！', 'Warning!')
else
    dis = D(start, stop); %指定两结点间的最短距离
    m(1) = start;
    i = 1;

    while P(m(i),stop) ~= stop
        k = i + 1;
        m(k) = P(m(i),stop);
        i = i + 1;
    end
    m(i+1) = stop;
    path = m; %指定两结点之间的最短路径
end
end