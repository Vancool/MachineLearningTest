function [accuracy guess]=handWritingWithKNNs(K,options)
%input:
	%K               -KNN's K
	%options         -a vector to select kind of distance and voting ways,[distance option,voting way option]
	%                kind of distance 1-Euclidean distance,2-Manhattan Distance,3-Cosine similarity
	%                voting ways      1-voteing without weight,2-weight:1/(distance)^2
	%                example of options--->[1,1],[1,2] and so on.
%output:
	%accuracy of KNN -accuracy
	%guess           -the predict label of test data
if (K-K/2)==0
	disp('invalid input!')
	return
end
if max(size(options))>=3||max(size(options))<1
 	disp('invalid input!');
 	return
elseif max(size(options))==1
	options(2)=1; 	
end
%load data
load('testData.mat');%testData is a 946*1 Matrix cell
load('TestDataLabel.mat');%TestDataLabel is 946 arraylist
load('trainData.mat');%trainData is a 1934*1 Matrix cell
load('TrainDataLabel.mat');%TrainDataLabel is 1934 arraylist
testNumber=length(TestDataLabel);
errorNumber=0;
guess=[];
for i=1:testNumber
	guessLabel=KNNs(testData{i},trainData,TrainDataLabel,K,options(1),options(2));
    guess=[guess guessLabel];
	realLabel=TestDataLabel(i);
	if(realLabel~=guessLabel)
		errorNumber=errorNumber+1;
    end
end
accuracy=100-double(errorNumber)/double(testNumber)*100;
%                kind of distance 1-Euclidean distance,2-Manhattan Distance,3-Cosine similarity
%                voting ways      1-voteing without weight,2-weight:1/(distance)^2
if(options(1)==1&&options(2)==1)
	disp('Euclidean distance && voteing without weight')
	accuracy
elseif (options(1)==2&&options(2)==1)
	disp('Manhattan Distance && voteing without weight')
	accuracy
elseif(options(1)==3&&options(2)==1)
	disp('Cosine similarity && voteing without weight')
	accuracy
elseif(options(1)==1&&options(2)==2)
	disp('Euclidean distance && 1/(distance)^2')
	accuracy
elseif (options(1)==2&&options(2)==2)
	disp('Manhattan Distance && 1/(distance)^2')
	accuracy
elseif(options(1)==3&&options(2)==2)
	disp('Cosine similarity && 1/(distance)^2')
	accuracy
end
		