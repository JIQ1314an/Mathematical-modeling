%Test the model on the remaining testing data and obtain the recognition rate.
clear;
load model.mat;
load xTesting.mat;
load yTesting.mat;
% yPred 是对每个样本预测的标签； accuracy是在测试集上整体的识别率
% decisionValue: 是w^TX + b 的值；就是根据这个值贴标签
[yPred,accuracy,decisionValues] = svmpredict(yTesting,xTesting,model); 

%draw ROC                                  
[totalScores,index]  = sort(decisionValues);  % 先排序
labels = yTesting;
for i = 1:length(labels)
    labels(i) = yTesting(index(i)); % 将decisionValue与标签值对应起来。
end


truePositive = zeros(1,length(totalScores)+1);
trueNegative = zeros(1,length(totalScores)+1);
falsePositive = zeros(1,length(totalScores)+1);
falseNegative = zeros(1,length(totalScores)+1);

% 计算TP和FP的总的个数. 索引数一直为1；
for i = 1:length(totalScores)
    if labels(i) == 1
        truePositive(1) = truePositive(1)+1; 
    else
        falsePositive(1) = falsePositive(1) +1;
    end
end

% FP: 是如何得出来的： 原本是不能通过，认成了pass, label = -1;
% 由于排好序列了，那么，TP 和 FP的个数，其实是递减的。
for i = 1:length(totalScores)
   if labels(i) == 1
       truePositive(i+1) = truePositive(i)-1;
       falsePositive(i+1) = falsePositive(i);
   else
       falsePositive(i+1) = falsePositive(i)-1;
       truePositive(i+1) = truePositive(i);
   end
end

% 概率化；
truePositive = truePositive/truePositive(1);
falsePositive = falsePositive/falsePositive(1);
plot(falsePositive, truePositive);

inc = 0.001;
startIndex = 1;
endIndex = length(falsePositive);
pointerIndex = 1;
pointerValue = falsePositive(1);
newFalsePositive = [];
newTruePositive = [];
while pointerIndex<=length(falsePositive)
    while pointerIndex<=length(falsePositive) && falsePositive(pointerIndex)>falsePositive(startIndex)-inc 
        pointerIndex = pointerIndex +1;
    end
    newFalsePositive = [newFalsePositive, falsePositive(startIndex)];
    newTruePositive = [newTruePositive, mean(truePositive(startIndex:min(pointerIndex,length(truePositive))))];
    startIndex = pointerIndex;
end

plot(newFalsePositive, newTruePositive, 'g'); %绘制ROC曲线