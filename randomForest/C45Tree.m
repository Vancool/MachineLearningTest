%original C4.5 Tree,without any cuts
%using recursive funtion to construct the tree
function treeRoot=C45Tree(dataMatrix,partition,activePart,labels)
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
	%count the Gain and find  the gain of feature better than average gain,and make a feature set H 
	%then find the highest gain ratio feature in the set H
	gainAverage=0;
	gainRatio=-inf;
    maxGain=-inf;
	row=0;
	col=0;
    lessSet=[];
    moreSet=[];
	%feature [1,2,3,4]
	K=0;
	for i=1:4
		for j=1:length(partition(1,:))
			if activePart(i,j)==1
				[result,lessSet1,moreSet1]=countGain(dataMatrix,i,partition(i,j),labels);
				gainAverage=result+gainAverage;
                if maxGain<result
                    maxGain=result;
                    lessSet=lessSet1;
                    moreSet=moreSet1;
					row=i;
                    col=j;
                end
				K=K+1;
			end
        end
    end
  
	gainAverage=gainAverage/K;
	for i=1:4
		for j=1:length(partition(1,:))
			if activePart(i,j)==1
				[result,lessSet1,moreSet1]=countGain(dataMatrix,i,partition(i,j),labels);
				if(result>gainAverage)
					result=getGainRatio(result,lessSet1,moreSet1);
					if(result>=gainRatio)
						lessSet=lessSet1;
	                    moreSet=moreSet1;
						gainRatio=result;
						row=i;
						col=j;
					end                 
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
    	treeRoot.left=C45Tree(lessSet,partition,activePart,labels);
    end
    if(isempty(moreSet))
    	leaf=struct('feature','0','value','null','left','null','right','null');
    	leaf.value=max(dataMatrix(:,5));
    	treeRoot.right=leaf;
    else
    	treeRoot.right=C45Tree(moreSet,partition,activePart,labels);	
    end

end