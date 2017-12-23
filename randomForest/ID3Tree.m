%original ID3 Tree,without any cuts
%using recursive funtion to construct the tree
function treeRoot=ID3Tree(dataMatrix,partition,activePart,labels)
%output:
    %treeRoot      -the ancestors of the branch nodes ecept itself
%input:
	%dataMatrix    -the data matrix
	%partition     -the partition matrix
	%activePart    -the matrix represent if the element of partition matrix is valid.
	%labels        -the labels array
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
    if (isempty(lessSet))
    	%lessSet have no elment
    	%so use the maximum label to be its value(result label)
    	leaf=struct('feature','0','value','null','left','null','right','null');
    	leaf.value=max(dataMatrix(:,5));
    	treeRoot.left=leaf;
    else
    	treeRoot.left=ID3Tree(lessSet,partition,activePart,labels);
    end
    if(isempty(moreSet))
    	leaf=struct('feature','0','value','null','left','null','right','null');
    	leaf.value=max(dataMatrix(:,5));
    	treeRoot.right=leaf;
    else
    	treeRoot.right=ID3Tree(moreSet,partition,activePart,labels);	
    end

end