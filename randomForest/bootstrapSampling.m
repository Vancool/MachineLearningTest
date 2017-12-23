%boostrap sampling to get data for building decision tree
function data=bootstrapSampling(trainData)
%input:
%	trainData		-data for training
%output:
%	data 			-the data for building decision tree

[n,m]=size(trainData);
index=randi(n,1,n);
index=unique(index);
data=trainData(index,:);
end