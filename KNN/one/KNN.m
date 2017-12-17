function resultLabel=KNN(sample,trainData,trainLabel,k)
%input:
	%sample      -one of TestData's feature vector,in this case the feature is every pixel
	%trainData   -train data, cell matrix
	%trainLabel  -train label,int arraylist
	%k           -KNN's k,the number of selecting data
%output:
	%resultLabel -the sample predict label
	N=length(trainLabel);
	PointDistance=zeros(1,N);
	for i=1:N
		I=trainData{i};
		I=(sample-I).^2;
		PointDistance(i)=sqrt(sum(I(:)));%distance
    end
	%find the min then vote
	result=zeros(1,10);
	for j=1:k
		voteCol=find(PointDistance==min(PointDistance));%get the min distance col
        voteCol=voteCol(1);
		voteData=trainLabel(voteCol);%the label is 0-9,but the index of array is 1-10
		result(voteData+1)=result(voteData+1)+1;
		PointDistance(voteCol)=inf;
	end
	resultLabel=find(result==max(result))-1;
    resultLabel=resultLabel(1);
end