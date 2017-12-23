function result=getAccuracy(testData,forest,labels)
%get random forest accuracy
%input:
%		testData	-data for testing
%		forest		-the random forest
%		labels		-the labels array
%output:
%		result		-accuracy
accuracy=0;

currentTestData=testData;
[m,n]=size(currentTestData);
errorNum=0;
for j=1:m
	currentData=currentTestData(j,:);
	label=getForestLabel(forest,currentData,labels);
	if(label~=currentData(end))
		errorNum=errorNum+1;
	end
end
accuracy=accuracy+(1-double(errorNum)/double(m))*100;

result=accuracy;
end