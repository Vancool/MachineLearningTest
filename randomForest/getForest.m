function result=getForest(k,trainData,labels,selection)
%get random forest
%input:
%	k			- number of decision trees
%	trainData	-data for training 
%	labels 		-the labels array
%	selection 	-the selection to choose which kind of tree you want to make,1-ID3 tree,2-C4.5 tree
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
    if selection==1
		treeRoot=ID3Tree(trainData,partitionMatrix,activePartMatrix,labels);
	end
	if selection==2
		treeRoot=C45Tree(trainData,partitionMatrix,activePartMatrix,labels);
	end
	result{time}=treeRoot;
end
end