function [accuracy guess]=handWriting(K)
%input:
	%K      -KNN's k
%output:
	%result -accuracy
	%guess  -the predict label of testData.mat
%load data
load('testData.mat');%testData is a 946*1 Matrix cell
load('TestDataLabel.mat');%TestDataLabel is 946 arraylist
load('trainData.mat');%trainData is a 1934*1 Matrix cell
load('TrainDataLabel.mat');%TrainDataLabel is 1934 arraylist
testNumber=length(TestDataLabel);
errorNumber=0;
guess=[];
for i=1:testNumber
	guessLabel=KNN(testData{i},trainData,TrainDataLabel,K);
    guess=[guess guessLabel];
	realLabel=TestDataLabel(i);
	if(realLabel~=guessLabel)
		errorNumber=errorNumber+1;
    end
end
accuracy=100-double(errorNumber)/double(testNumber)*100;





