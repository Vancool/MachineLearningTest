%post-pruning ID3 Tree
%using recursive funtion to construct the tree
function treeRoot=postpruningID3(dataMatrix,partition,activePart,labels,testDataMatrix)
	%treeRoot      -the ancestors of the branch nodes ecept itself
	%dataMatrix    -the data matrix for trainint the tree
	%partition     -the partition matrix
	%activePart    -the matrix represent if the element of partition matrix is valid.
	%labels        -the labels array
	featureNum=size(activePart,1);
	partitionNum=size(activePart,2);
	dataNum=size(dataMatrix,1);
	testDataNum=size(testDataMatrix,1);
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
    if (isempty(lessSet))
    	%lessSet have no elment
    	%so use the maximum label to be its value(result label)
    	leaf=struct('feature','0','value','null','left','null','right','null');
    	leaf.value=max(dataMatrix(:,5));
    	treeRoot.left=leaf;
    else
    	treeRoot.left=postpruningID3(lessSet,partition,activePart,labels,testDataMatrix);
    end
    if(isempty(moreSet))
    	leaf=struct('feature','0','value','null','left','null','right','null');
    	leaf.value=max(dataMatrix(:,5));
    	treeRoot.right=leaf;
    else
    	treeRoot.right=postpruningID3(moreSet,partition,activePart,labels,testDataMatrix);	
    end


    %pruning proceed
    pruneError=0;
    noPruneError=0;
    %count pruneError
    maxLabelValue=max(dataMatrix(:,5));
    for i=1:testDataNum
    	if(testDataMatrix(i,5)~=maxLabelValue)
    		pruneError=pruneError+1;
    	end
    end

    %count noPruneError
    for i=1:testDataNum
    	if(findLabel(treeRoot,testDataMatrix(i,:))~=testDataMatrix(i,5))
    		noPruneError=noPruneError+1;
    	end
    end

    if pruneError<noPruneError
    	% pruning is better ,cut the tree root
    	treeRoot.feature='0';
    	treeRoot.value=maxLabelValue;
    	treeRoot.left=[];
    	treeRoot.right=[];
    end
end