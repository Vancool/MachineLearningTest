clc,clear
load('trainSet.mat');
load('testSet.mat');

currentTrainSet=trainSet{1};
[forest,feature]=getForest(10,currentTrainSet,[1 2 3]);
accuracy=getAccuracy(testSet,forest,[1 2 3])
