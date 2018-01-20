%boostrap sampling to get data for building decision tree
function [data,data2]=bootstrapSampling(trainData)
%input:
%	trainData		-data for training
%output:
%	data 			-the data for building decision tree
%   data2			-the data for testing
[n,m]=size(trainData);
k=[1:n];
index=randi(n,1,n);
index=unique(index);
k=setdiff(k,index);
data=trainData(index,:);
data2=trainData(k,:);
end