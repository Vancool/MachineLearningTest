function [result,lessSet,moreSet]=countGain(dataSet,feature,partition,labelPosibility)
	%result     -the information gain of the feature
	%partition  -the divide to separate data set into two different set
	%lessSet    -the set that value of feature is less than partition
	%moreSet    -the set that value of feature is more than partition
	%when determining which information gain is the largest
	% the Ent(D) in Ent(D)-sum(|Dv|/|D|*Ent(D)) is the same
	y=length(labelPosibility);	
	n=size(dataSet,1);
	%sort the dataSet by col
	EntD=Ent(dataSet,labelPosibility);
	%feature posibility is a continuous value
	dataSet=sortrows(dataSet,feature);
	testCol=dataSet(:,feature);
	lessIndex=max(find(testCol<partition));
	lessSet=dataSet(1:lessIndex,:);
    if(isempty(lessIndex))
        moreSet=dataSet;
        result=EntD-1*Ent(moreSet,labelPosibility);
    elseif lessIndex==n
        moreSet=[];
        result=EntD-1*Ent(lessSet,labelPosibility);
    else
      	moreSet=dataSet(lessIndex+1:n,:);  
        result=EntD-lessIndex/n*Ent(lessSet,labelPosibility)-(1-lessIndex/n)*Ent(moreSet,labelPosibility);
    end
	
end