clc,clear
%test myKmeans
load('trainData.mat');
[result performance]=myKmeans(3,trainData,[trainData(1,:);trainData(2,:);trainData(3,:)],100000,10^(-5));