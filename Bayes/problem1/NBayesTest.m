function result=NBayesTest(number,data,FeaturePosibility)
%input:
%  	 number    				-the number of data for training 
%	 data      				-the whole data
%	 FeaturePosiibility 	-the feature 
%output:
%    result                 -accuracy
	trainData=data(1:number,:);
	testData=data(number+1:end,:);
	n=size(testData,1);
	[priors,likehood]=NBayes(trainData,FeaturePosibility);
	errorNum=0;
	labelNum=FeaturePosibility(end);
	featureNum=length(FeaturePosibility)-1;
	for i=1:n
		tdata=testData(i,:);
		%count the posibility of each label
		%and find the maximum of posibility
		result=zeros(1,labelNum);
		for j=1:labelNum
			priorsNum=priors(j);
			likehoodCol=likehood(:,j);
			for k=1:featureNum
				currentValue=tdata(k);
				conP=likehoodCol{k};
				priorsNum=priorsNum*conP(currentValue);
			end
			result(j)=priorsNum;
		end
		[maxNum,maxIndex]=max(result);
		if maxIndex~=tdata(length(FeaturePosibility))
			errorNum=errorNum+1;
		end
	end
	result=(1-double(errorNum)/double(size(data,1)-number))*100;
end