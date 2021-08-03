%%%%%%%%%%%%%%%%%%%%%%%%
%Normalization ��һ��
[numVec,numDim] = size(xTraining);
avgX = mean(xTraining);  % �����Ƕ�ÿһ����ƽ��ֵ
stdX = std(xTraining);   % ��ÿһ���󷽲�

for i = 1:numVec       % ���б�����������
    xTraining(i,:) = (xTraining(i,:)-avgX)./stdX;
end

[numVec,numDim] = size(xTesting);

for i = 1:numVec
    xTesting(i,:) = (xTesting(i,:)-avgX)./stdX;
end