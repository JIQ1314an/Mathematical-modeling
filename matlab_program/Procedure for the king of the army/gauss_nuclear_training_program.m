%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SVM Gaussian kernel 
%Search for the optimal C and gamma, K(x1,x2) = exp{-||x1-x2||^2/gamma} to
%make the recognition rate maximum. 

%Firstly, search C and gamma in a crude scale (as recommended in 'A practical Guide to Support Vector Classification'))
CScale = [-5, -3, -1, 1, 3, 5,7,9,11,13,15];
gammaScale = [-15,-13,-11,-9,-7,-5,-3,-1,1,3];
C = 2.^CScale;
gamma = 2.^gammaScale;
maxRecognitionRate = 0;
for i = 1:length(C)  % 找到最佳的超参数 c 和 gama 的下标
    for j = 1:length(gamma)   % svm训练参数设置：
        cmd=['-t 2 -c ',num2str(C(i)),' -g ',num2str(gamma(j)),' -v 5'];
        recognitionRate = svmtrain(yTraining,xTraining,cmd); %训练数据和参数
        if recognitionRate>maxRecognitionRate
            maxRecognitionRate = recognitionRate
            maxCIndex = i;
            maxGammaIndex = j;
        end;
    end;
end;

%Then search for optimal C and gamma in a refined scale. 
n = 10; % 用最好的超参数，重新训练 %max 是返回最大的数
minCScale = 0.5*(CScale(max(1,maxCIndex-1))+CScale(maxCIndex));
maxCScale = 0.5*(CScale(min(length(CScale),maxCIndex+1))+CScale(maxCIndex));
newCScale = [minCScale:(maxCScale-minCScale)/n:maxCScale];

minGammaScale = 0.5*(gammaScale(max(1,maxGammaIndex-1))+gammaScale(maxGammaIndex));
maxGammaScale = 0.5*(gammaScale(min(length(gammaScale),maxGammaIndex+1))+gammaScale(maxGammaIndex));
newGammaScale = [minGammaScale:(maxGammaScale-minGammaScale)/n:maxGammaScale];
newC = 2.^newCScale;
newGamma = 2.^newGammaScale;
maxRecognitionRate = 0;
for i = 1:length(newC)
    for j = 1:length(newGamma)
        cmd=['-t 2 -c ',num2str(newC(i)),' -g ',num2str(newGamma(j)),' -v 5'];
        recognitionRate = svmtrain(yTraining,xTraining,cmd);
        if recognitionRate>maxRecognitionRate
            maxRecognitionRate = recognitionRate
            maxC = newC(i);
            maxGamma = newGamma(j);
        end;
    end;
end;

%Train the SVM model by the optimal C and gamma.
cmd=['-t 2 -c ',num2str(maxC),' -g ',num2str(maxGamma)];
model = svmtrain(yTraining,xTraining,cmd);
save model.mat model;
save xTesting.mat xTesting;
save yTesting.mat yTesting;