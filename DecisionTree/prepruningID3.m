%make post-pruning ID3 tree
%using recursive funtion to construct the tree
function treeRoot=prepruningID3(dataMatrix,partition,activePart,labels,testDataMatrix)
%output:
    %treeRoot      -the ancestors of the branch nodes ecept itself
%input:
	%dataMatrix    -the data matrix
	%partition     -the partition matrix
	%activePart    -the matrix represent if the element of partition matrix is valid.
	%labels        -the labels array
    %testDataMatrix-the matrix use to prune the tree
	featureNum=size(activePart,1);
	partitionNum=size(activePart,2);
	dataNum=size(dataMatrix,1);
	labelNum=length(labels);
	%use struct to construct the tree
	treeRoot=struct('feature','0','value','null','left','null','right','null');
	% the return condition
	% if all labels of the data are same,return the labels
	sameIndex=find(dataMatrix(:,5)==dataMatrix(1,5));
	if(length(sameIndex)==dataNum)
		treeRoot.value=dataMatrix(1,5);
		return 
	end
	%if all elements of activePart are 0,which refer to there are no partition to count Gain
	%return the max label
	if(sum(activePart(:))==0)
		treeRoot.value=max(dataMatrix(:,5));
		return
	end
	%count the Gain to find the best partition of the feature
	gainResult=-inf;
	row=0;
	col=0;
    lessSet=[];
    moreSet=[];
	%feature [1,2,3,4]
	for i=1:4
		for j=1:length(partition(1,:))
			if activePart(i,j)==1
				[result,lessSet1,moreSet1]=countGain(dataMatrix,i,partition(i,j),labels);
				if(result>gainResult)
                    lessSet=lessSet1;
                    moreSet=moreSet1;
					gainResult=result;
					row=i;
					col=j;
				end
			end
		end
    end
	activePart(row,col)=0;
	treeRoot.value=partition(row,col);
	treeRoot.feature=row;
    
    
    
    %pruning proceed
    pruneError=0;
    noPruneError=0;
    if (isempty(lessSet))
    	%lessSet have no elment
    	%so use the maximum label to be its value(result label)
    	leaf=struct('feature','0','value','null','left','null','right','null');
    	leaf.value=max(dataMatrix(:,5));
    	treeRoot.left=leaf;
    else
        lessLabel=max(lessSet(:,5));
    	leaf=struct('feature','0','value',lessLabel,'left','null','right','null');
        treeRoot.left=leaf;
    end
    if(isempty(moreSet))
    	leaf=struct('feature','0','value','null','left','null','right','null');
    	leaf.value=max(dataMatrix(:,5));
    	treeRoot.right=leaf;
    else
        moreLabel=max(moreSet(:,5));
        leaf=struct('feature','0','value',moreLabel,'left','null','right','null');
        treeRoot.right=leaf;
    end
    dataLabel=max(dataMatrix(:,5));
    testDataNum=size(testDataMatrix,1);
    %count prune error
    for i=1:testDataNum
    	if(testDataMatrix(i,5)~=dataLabel)
    		pruneError=pruneError+1;
    	end
    end
    %cout noPrune error
    for i=1:testDataNum
    	if(findLabel(treeRoot,testDataMatrix(i,:))~=testDataMatrix(i,5))
    		noPruneError=noPruneError+1;
    	end
    end
    if(noPruneError<pruneError)
    	if(~isempty(lessSet)) 
            treeRoot.left=prepruningID3(lessSet,partition,activePart,labels,testDataMatrix);
    	end
    	if(~isempty(moreSet))
             treeRoot.right=prepruningID3(moreSet,partition,activePart,labels,testDataMatrix);
    	end
    else
        treeRoot.feature='0';
        treeRoot.value=dataLabel;
        treeRoot.right=[];
        treeRoot.left=[];
    end
end