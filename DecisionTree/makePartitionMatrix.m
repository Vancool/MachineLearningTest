 %the partition is middle value of two value
 %using bi-partition  in page84
 function [partitionMatrix,activePartMatrix]=makePartitionMatrix(trainMatrix)
 %input:
 %     trainMatrix      -the 120*5 data matrix for training the learner

 %output:
 %     partitionMatrix  -using bi-partition to discretize data,one row is reprensent one feature,col is partition value of feature 
 %     activePartMatrix -the element of this matrix is show if the partition feature is valid
 [n,m]=size(trainMatrix);
 featureNum=m-1;
 partitionMatrix=zeros(featureNum,n-1);
 activePartMatrix=zeros(featureNum,n-1);
 for j=1:featureNum
 	%sort the matrix with each value of feature to find the feature's partition
 	trainMatrix=sortrows(trainMatrix,j);
 	for k=1:n-1
 		if trainMatrix(k,j)==trainMatrix(k+1,j)
 			partitionMatrix(j,k)=0;
 		else
 			%the partition is middle value of two value
            activePartMatrix(j,k)=1;
            %using bi-partition  in page84
            partitionMatrix(j,k)=1/2*(trainMatrix(k,j)+trainMatrix(k+1,j));
 		end
 	end
 end
 end