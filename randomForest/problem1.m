clc,clear
load('trainSet.mat');
load('testSet.mat');
m=length(trainSet);%
accuracySet=zeros(10,1);
for k=1:10%number of tree in random forest
	for iteration=1:20%time of random 
		accuracy=0;
		for i=1:m
			currentTrainSet=trainSet{i};
			currentTestSet=testSet{i};
			forest=getForest(k,currentTrainSet,[1 2 3]);
			accuracy=accuracy+getAccuracy(currentTestSet,forest,[1 2 3]);
		end
		accuracy=accuracy/m;%get accuracy of this time random forest model
		accuracySet(k)=accuracySet(k)+accuracy;
	end
	accuracySet(k)=accuracySet(k)/20;%train k-random forest for 20 time and count  accuracy
end
%plot
%k-the number of tree
%y-the accuracy of random forest
k=[1:1:10];
plot(k,accuracySet,'r-*');
title('k-accuracy gragh')
xlabel('k (the tree number in forest)')
ylabel('average accuracy %')
str=[num2str(accuracySet)];
text(k,accuracySet,cellstr(str));