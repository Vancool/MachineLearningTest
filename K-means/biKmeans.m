function [result,performance]=biKmeans(k,data)
%bi k-mean
%input:
%	k 		-clustering into k classes
% 	data 	-the data matrix
%output:
%	result			-an	(k*1)cell matrix,one element is one class information including the E=sum(distance^2),class center and class data
%	performance		-the performance of k-means ,
%						 performance(1) is measure by sum(distance^2 of class(i))
%						 performance(2)	is measure by E(radius of class);
	[m,n]=size(data);
	result=cell(k,3);
	meanVector=[];
	meanVector=sum(data)/m;
	dis=zeros(m,1);
	minSumDis=0;
	for i=1:m
		dis(i)=norm(data(i,:)-meanVector)^2;
	end
	minSumDis=sum(dis);
	number=0;
	currentData=data;
	clusterSet={};
	while(number<k)
		minCost=inf;
		currentSplit=0;
		for i=1:20
            m=size(currentData,1);
			center=sampling(1:m,2);
            center=currentData(center,:);
			[res,perf]=myKmeans(2,currentData,center,10^5,10^(-5));
			if(perf(1)<minCost)
				currentSplit=res;
				minCost=perf(1);
			end
		end

		%find the max cost cluster
		clusterSet=[clusterSet;res];
        if(size(clusterSet,1)==k)
            break;
        end
		[~,maxCostIndex]=max(cell2mat(clusterSet(:,3)));
		currentData=clusterSet{maxCostIndex,2};
		clusterSet(maxCostIndex,:)=[];
		number=size(clusterSet,1);
	end

	%store the result and count the performance
	result=clusterSet;
	performance(1)=sum(cell2mat(clusterSet(:,3)));
	radius=0;
	for i=1:k
		maxR=0;
		currentData=clusterSet{i,2};
		currentMeanVector=clusterSet{i,1};
		for j=1:size(currentData,1)
			if(maxR<norm(currentData(j,:)-currentMeanVector))
				maxR=norm(currentData(j,:)-currentMeanVector);
			end
		end
		radius=radius+maxR;
	end
	performance(2)=radius/k;

end