%my k-means function
function [result,performance]=myKmeans(k,data,center,N,tol)
%input:
%	k 				-clustering into k classes
%	data			-the data matrix
%	center 			-the class center,mean vector	
% 	N 				-the maximum number of iteration	
% 	tol				-the min change of mean vector 
%output:
%	result			-an	(k*1)cell matrix,one element is one class information including the E=sum(distance^2),class center and class data
%	performance		-the performance of k-means ,
%						 performance(1) is measure by sum(distance^2 of class(i))
%						 performance(2)	is measure by E(radius of class);
if(size(center,1)~=k)
	disp('wrong input:the number of center point must be equel with k!')
	return
end
%original the variance and output
	result=cell(k,3);
	meanVector=center;
	[dataNum,featureNum]=size(data);%the number of data set and feature number
	classLabel=zeros(dataNum,1);% record the class of data
	classE=zeros(k,1);% record the sum dis^2 of the whole class data 
	classSize=zeros(k,1);%record the class size
	resultSet=cell(k,1);
	for i=1:k
		resultSet{i}=[];
	end

%count the E=sum(distance^2)
	centerDis=zeros(1,k);
	for i=1:dataNum
		currentData=data(i,:);
		currentLabel=0;
		minDis=inf;
		for j=1:k
			dis=sum((currentData-meanVector(j,:)).^2);
			if minDis>dis
				minDis=dis;
				currentLabel=j;
			end
		end
		classE(currentLabel)=classE(currentLabel)+minDis;
		classSize(currentLabel)=classSize(currentLabel)+1;
		classLabel(i)=currentLabel;
		resultSet{currentLabel}=[resultSet{currentLabel};data(i,:)];
	end

%updata meanVector
	newMeanVector=zeros(k,featureNum);
	for i=1:dataNum
		for j=1:k
			if(classLabel(i)==j)
				newMeanVector(j,:)=newMeanVector(j,:)+data(i,:);
			end
		end
	end
	for i=1:k
		newMeanVector(i,:)=newMeanVector(i,:)/classSize(i);
	end

%begin iteration
	n=1;
	while(norm(newMeanVector-meanVector)>tol&&n<N)
		for i=1:k
			resultSet{i}=[];
		end
		classLabel=zeros(dataNum,1);
		classE=zeros(k,1);
		classSize=zeros(k,1);
		meanVector=newMeanVector;
		centerDis=zeros(1,k);
		for i=1:dataNum
			currentData=data(i,:);
			currentLabel=0;
			minDis=inf;
			for j=1:k
				dis=sum((currentData-meanVector(j,:)).^2);
				if minDis>dis
					minDis=dis;
					currentLabel=j;
				end
			end
			classE(currentLabel)=classE(currentLabel)+minDis;
			classSize(currentLabel)=classSize(currentLabel)+1;
			classLabel(i)=currentLabel;
			resultSet{currentLabel}=[resultSet{currentLabel};data(i,:)];
		end


		%updata meanVector
		newMeanVector=zeros(k,featureNum);
		for i=1:dataNum
			for j=1:k
				if(classLabel(i)==j)
					newMeanVector(j,:)=newMeanVector(j,:)+data(i,:);
				end
			end
		end
		for i=1:k
			newMeanVector(i,:)=newMeanVector(i,:)/classSize(i);
		end
		n=n+1;
	end

	if(n>=N)
		disp('k-means cannot find a good clustering,the error of mean vector is :')
		norm(newMeanVector-meanVector)
	end
	meanVector=newMeanVector;

%store the result and return the result cell matrix
	for i=1:k
		result{i,1}=meanVector(i,:);
		result{i,2}=resultSet{i};
		result{i,3}=classE(i);
	end

%count the performance
	performance=zeros(2,1);
	sumE=0;
	for i=1:k
		sumE=sumE+classE(i);
	end
	performance(1)=sumE;
	%find the maximum radius
		radius=zeros(k,1);
		for i=1:size(data,1)
			for j=1:k
				if(classLabel(i)==j)
					if(radius(j)<norm(data(i)-meanVector(j,:)))
						radius(j)=norm(data(i)-meanVector(j,:));
					end
				end
			end	
		end
		performance(2)=sum(radius)/k;
end