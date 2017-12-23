function result=getForest(k,trainData,labels)
%get random forest
%input:
%	k			- number of decision trees
%	trainData	-data for training 
%	labels 		-the labels array
%output:
% 	result		-forest, cell matrix containing k trees struct
[n,m]=size(trainData);
[partitionMatrix,activePartMatrix]=makePartitionMatrix(trainData);
[a,b]=size(partitionMatrix);
p=floor(log2(a));%the feature number in decision tree
%build tree and store in the forest
result=cell(1,k);
for time=1:k
	%origin the feature matrix
	[partitionMatrix,activePartMatrix]=makePartitionMatrix(trainData);
	%get random feature from partition matrix and active part matrix
	index=randi(a,1,p);
    while(length(unique(index))~=p)
        index=randi(a,1,p);
    end
    index=setdiff([1:a],index);
    activePartMatrix(index,:)=0;
	treeRoot=ID3Tree(trainData,partitionMatrix,activePartMatrix,labels);
	result{time}=treeRoot;
end
end