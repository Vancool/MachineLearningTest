function resultLabel=KNNs(sample,trainData,trainLabel,k,option1,option2)
%input:
	%sample      -one of TestData's feature vector,in this case the feature is every pixel
	%trainData   -train data, cell matrix
	%trainLabel  -train label,int arraylist
	%k           -KNN's k,the number of selecting data
	%option1     -the option of use which kind of distance,1-Euclidean distance,2-Manhattan Distance,3-Cosine similarity
	%option2	 -the option of use which kind of voting way,1-voteing without weight,2-weight:1/(distance)^2
%output:
	%resultLabel -the predit label of sample
	N=length(trainLabel);
	PointDistance=zeros(1,N);
	for i=1:N
		I=trainData{i};
		if option1==1
		% Euclidean distance
			I=(sample-I).^2;
			PointDistance(i)=sqrt(sum(I(:)));
		elseif option1==2
			%Manhattan distance
			I=abs(sample-I);
			PointDistance(i)=sum(I(:));
		elseif option1==3
			%Cosine similartity
			K=I.*sample;
			I=I.*I;
			sample1=sample.*sample;
			if sum(I(:))==0||sum(sample1(:))==0
				%if ==0 the function below is NaN
				PointDistance(i)=inf;
            else
				PointDistance(i)=sum(K(:))/(sqrt(sum(I(:)))*sqrt(sum(sample1(:))));
			end
			
		end
		
    end
	%find the min then vote
	result=zeros(1,10);

	for j=1:k
        if option1==3
        	% Point distance in[-1,1],max distance is represent the better similarity between sample and data
        	voteCol=find(PointDistance==max(PointDistance));
        else
        	voteCol=find(PointDistance==min(PointDistance));%get the min distance col
        end
	    voteCol=voteCol(1);
		voteData=trainLabel(voteCol);
		if option2==1
			%the label is 0-9,but the index of array is 1-10
			%voteing without weight
			result(voteData+1)=result(voteData+1)+1;
			PointDistance(voteCol)=inf;	
		elseif option2==2
			%weight:1/(distance)^2
			reLabel=voteData;
			if(PointDistance(voteCol)^2>0.0000001)
				voteData=voteData/(PointDistance(voteCol)^2);
			else
				voteData=inf;
			end
			result(reLabel+1)=result(reLabel+1)+voteData;
          
			
        end
     if option1==3
           PointDistance(voteCol)=-inf;
     else
           PointDistance(voteCol)=inf;   
     end
		
	end
	resultLabel=find(result==max(result))-1;
    resultLabel=resultLabel(1);
end



