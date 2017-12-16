function [result,accuracy]=rBayes(meanValue,prior,convariance,riskMatrix,testData,label)
%input:
	%meanValue         -matrix of mean of feature,each row is one label's feature mean
	%prior             -vector of prior of label
	%convariance       -convariance cell matrix
	%testData          -test data for predicting the result,matrix
	%riskMatrix        -risk matrix
	%label             -the sort of label
%output:
	%result            -the predict label for testData
	%accuracy          -the accuracy of rBayes
labelNum=length(prior);
featureNum=size(meanValue,1);
testNum=size(testData,1);
result=zeros(testNum,1);

%get result

for i=1:testNum
	%count one result
	currentData=testData(i,1:featureNum);
	resultPos=zeros(labelNum,1);
	pos=zeros(labelNum,1);
	%get the posibility of label
	for j=1:labelNum
		mul=meanValue(j,:);
		pos(j)=1/((2*pi)^(featureNum/2)*(det(convariance{j})^(1/2)))*exp(-1/2*(currentData-mul)*inv(convariance{j})*(currentData-mul)');
		pos(j)=pos(j)*prior(j);
	end
	%count with risk matrix
	resultPos=riskMatrix*pos;
	result1=find(resultPos==min(resultPos));
	result1=result1(1);
	result(i)=label(result1);
end

%count the accuracy
errorNum=0;
errorNum=length(find(result~=testData(:,featureNum+1)));
accuracy=(1-double(errorNum)/double(testNum))*100;
end