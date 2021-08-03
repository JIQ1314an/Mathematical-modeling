[N,M] = size(xapp);  % [N,M]是获取xapp的维度，例如3*4，N = 3,M = 4
p = randperm(M);     % 直接打乱了训练样本，并且把列数作为行向量保存
                     % 1~M的整数随机置换
numberOfSamplesForTraining = 5000;
xTraining = [];
yTraining = [];
for i=1:numberOfSamplesForTraining
    xTraining  = [xTraining,xapp(:,p(i))]; % 这是从总样本中，取随机一列的全部元素
    yTraining = [yTraining,yapp(p(i))];    % 这是取上面元素对应的标签
end
xTraining = xTraining'; % 取转置
yTraining = yTraining';

xTesting = [];
yTesting = [];
for i=numberOfSamplesForTraining+1:M       % 遍历剩下的数据作为测试数据
    xTesting  = [xTesting,xapp(:,p(i))];   % 注意同样用的p(i)
    yTesting = [yTesting,yapp(p(i))];
end
xTesting = xTesting'; % 取转置
yTesting = yTesting';