clc,clear
%test myKmeans
load('trainData.mat');
disp('test k-means' )
disp('k=3 : ')
[result performance]=myKmeans(3,trainData,[trainData(1,:);trainData(2,:);trainData(3,:)],100000,10^(-5));
disp('sum(distance^2),within-class scatter:')
performance(1)
disp('average radius:')
performance(2)
disp('between-class scatter:')
performance(3)
disp('separtion criterion:')
performance(4)