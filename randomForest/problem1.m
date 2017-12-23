clc,clear
load('trainSet.mat');
load('testSet.mat');
m=length(trainSet);
accuracySet=zeros(20,1);
for k=1:20
	for iteration=1:20
		accuracy=0;
		for i=1:m
			currentTrainSet=trainSet{i};
			currentTestSet=testSet{i};
			[forest,feature]=getForest(k,currentTrainSet,[1 2 3]);
			accuracy=accuracy+getAccuracy(currentTestSet,forest,[1 2 3]);
		end
		accuracy=accuracy/m;
		accuracySet(k)=accuracySet(k)+accuracy;
	end
	accuracySet(k)=accuracySet(k)/20;
end
k=[1:1:20];
plot(k,accuracySet,'r-*');
title('k-accuracy gragh')
xlabel('k (the tree number in forest)')
ylabel('average accuracy %')
str=[num2str(accuracySet)];
text(k,accuracySet,cellstr(str));