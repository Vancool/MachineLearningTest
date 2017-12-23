clc,clear
load('trainSet.mat');
load('testSet.mat');

currentTrainSet=trainSet{1};
forest=getForest(1,currentTrainSet,[1 2 3]);
accuracy=getAccuracy(testSet{3},forest,[1 2 3])
