function [priors,likehood]=NBayes(data,featurePosibility)
%input:
    %data               -dataMatrix
    %featurePosibility  -array of the number of type of features and labels
%output:
    %priors          -array of P(c(i))
    %likehood        -cell matrix of condition probability P(x|c)
    %                 row is feature ,col is label

%count priors
m=length(featurePosibility);
n=size(data,1);
labelNum=featurePosibility(m);
featureNum=m-1;
priors=zeros(labelNum,1);
sortSet=cell(labelNum,1);
for i=1:labelNum
	count=0;
	sortSet{i}=[];
	for j=1:n
		if data(j,7)==i
			count=count+1;
			sortSet{i}=[sortSet{i};data(j,:)];
		end
	end
	priors(i)=double(count+1)/double(n+labelNum);
end

%count likehood 
%using Laplacian correction
likehood=cell(featureNum,labelNum);
for i=1:labelNum
	%for every label
	labelDataSet=sortSet{i};
	labelSetNum=size(labelDataSet,1);
	for j=1:featureNum
		%now feature is j
		featureValueNum=featurePosibility(j);
		conP=zeros(1,featureValueNum);
		for k=1:featureValueNum
			count=0;
			for t=1:labelSetNum
				if (labelDataSet(t,j)==k)
					count=count+1;
				end
			end
			conP(k)=double(count+1)/double(labelSetNum+featureValueNum);
        end
       
		likehood(j,i)={conP};
	end
end