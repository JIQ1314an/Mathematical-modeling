[N,M] = size(xapp);  % [N,M]�ǻ�ȡxapp��ά�ȣ�����3*4��N = 3,M = 4
p = randperm(M);     % ֱ�Ӵ�����ѵ�����������Ұ�������Ϊ����������
                     % 1~M����������û�
numberOfSamplesForTraining = 5000;
xTraining = [];
yTraining = [];
for i=1:numberOfSamplesForTraining
    xTraining  = [xTraining,xapp(:,p(i))]; % ���Ǵ��������У�ȡ���һ�е�ȫ��Ԫ��
    yTraining = [yTraining,yapp(p(i))];    % ����ȡ����Ԫ�ض�Ӧ�ı�ǩ
end
xTraining = xTraining'; % ȡת��
yTraining = yTraining';

xTesting = [];
yTesting = [];
for i=numberOfSamplesForTraining+1:M       % ����ʣ�µ�������Ϊ��������
    xTesting  = [xTesting,xapp(:,p(i))];   % ע��ͬ���õ�p(i)
    yTesting = [yTesting,yapp(p(i))];
end
xTesting = xTesting'; % ȡת��
yTesting = yTesting';