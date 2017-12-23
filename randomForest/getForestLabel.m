function result=getForestLabel(forest,data,labels)
%uing decision trees forest to get data's label 
%input:
%	forest 			-the decision trees forest
%	data			-one data for testing
%	labels			-the labels array
%output:
%  	result			-the predicted label

treeNum=length(forest);
labelNum=length(labels);
vote=zeros(labelNum,1);
for i=1:treeNum
	treelabel=getTreeLabel(forest{i},data);
	vote(treelabel)=vote(treelabel)+1;
end
[~,index]=max(vote);
index=index(1);
result=labels(index);

end