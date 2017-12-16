function [result,trustPosibility]=myBayes(trainData,meanValue,prior,convariance,riskMatrix,testData,label)
%input:
	%trainData         -trian data for training,matrix
	%meanValue         -matrix of mean of feature,each row is one label's feature mean
	%prior             -vector of prior of label
	%convariance       -convariance cell matrix
	%testData          -test data for predicting the result,matrix
	%riskMatrix        -risk matrix
	%label             -the sort of label
%output:
	%result            -the predict label for testData
	%trustPosibility   -the [0-1]number using trianData to find if the myBayes is good learner for the data set
labelNum=length(prior);
featureNum=length(meanValue);
testNum=size(testData,1);
trainNum=size(trainData,1);
result=zeros(testNum,1);

%get result

for i=1:testData
	%count one result
	currentData=testData(i,:);
	resultPos=zeros(labelNum,1);
	pos=zeros(labelNum,1);
	%get the posibility of label
	for j=1:labelNum
		mul=meanValue(j,:);
		pos(j)=1/((2*pi)^(featureNum/2)*(det(convariance{j})^(1/2)))*exp(-1/2*(currentData-mul)'*inv(convariance{j})*(currentData-mul));
		pos(j)=pos(j)*prior(j);
	end
	%count with risk matrix
	resultPos=riskMatrix*pos;
	result1=find(resultPos==min(resultPos));
	result1=result1(1);
	result(i)=label(result1);
end

%count the trust by train data
errorNum=0;

for i=1:trainNum
	currentData=testData(i,1:featureNum);
	resultPos=zeros(labelNum,1);
	pos=zeros(labelNum,1);
	%get the posibility of label
	for j=1:labelNum
		pos(j)=1/((2*pi)^(featureNum/2)*(det(convariance{j})^(1/2)))*exp(-1/2*(currentData-meanValue)'*inv(convariance{j})*(currentData-meanValue));
		pos(j)=pos(j)*prior(j);
	end
	%count with risk matrix
	resultPos=riskMatrix*pos;
	result1=find(resultPos==min(resultPos));
	result1=result1(1);
	if currentData(featureNum+1)~=label(result1)
		errorNum=errorNum+1;
	end
end
trust=1-double(errorNum)/double(trianNum);
end