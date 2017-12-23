function [result feature]=getForest(k,trainData,labels)
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
p=sum(sum(activePartMatrix)); 
p=floor(log2(p));%the feature number in decision tree
%build tree and store in the forest
result=cell(1,k);
for time=1:k
	%origin the feature matrix
    currentPartitionMatrix=zeros(a,b);
    currentActivePartMatrix=zeros(a,b);
    fe=zeros(2,p);
	[partitionMatrix,activePartMatrix]=makePartitionMatrix(trainData);
	%get random feature from partition matrix and active part matrix
		for i=1:p
			randomNum=randi([1 a*b]);
			x=floor(randomNum/b);
            y=randomNum-x*b;
            if x~=a
            x=x+1;
            end
			y=y+1;
			if activePartMatrix(x,y)==0
				while(activePartMatrix(x,y)==0)
					randomNum=randi([1 a*b]);
					x=floor(randomNum/b);
                    y=randomNum-x*b;
                    if x~=a
                       x=x+1; 
                    end               
                    y=y+1;
				end
			end
				activePartMatrix(x,y)=0;
                currentPartitionMatrix(x,y)=partitionMatrix(x,y);
                currentActivePartMatrix(x,y)=1;
                fe(1,i)=x;
                fe(2,i)=y;
        end 
        feature{time}=fe;
	treeRoot=ID3Tree(trainData,currentPartitionMatrix,currentActivePartMatrix,labels);
	result{time}=treeRoot;
end
end