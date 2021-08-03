%%%%%%%%%%%%%%%%%%%%%%%%
%Normalization 归一化
[numVec,numDim] = size(xTraining);
avgX = mean(xTraining);  % 这里是对每一列求平均值
stdX = std(xTraining);   % 对每一列求方差

for i = 1:numVec       % 以行遍历所有数据
    xTraining(i,:) = (xTraining(i,:)-avgX)./stdX;
end

[numVec,numDim] = size(xTesting);

for i = 1:numVec
    xTesting(i,:) = (xTesting(i,:)-avgX)./stdX;
end