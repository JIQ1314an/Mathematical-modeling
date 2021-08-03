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
[D,path]=floyd(W)

function [D,path,min1,path1]=floyd(a,start,terminal)
D=a;n=size(D,1);path=zeros(n,n);
for i=1:n
    for j=1:n
        if D(i,j)~=inf
            path(i,j)=j;
        end,
    end,
end
for k=1:n
    for i=1:n
        for j=1:n
            if D(i,k)+D(k,j)<D(i,j)
                D(i,j)=D(i,k)+D(k,j);
                path(i,j)=path(i,k);
            end,
        end,
    end,
end
if nargin==3
    min1=D(start,terminal);
    m(1)=start;
    i=1;
    path1=[ ]; 
    while path(m(i),terminal)~=terminal
        k=i+1;
        m(k)=path(m(i),terminal);
        i=i+1;
    end
    m(i+1)=terminal;
    path1=m;
end
end

