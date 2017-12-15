function result=rBayes(data,risk,meanValue,variance,label)
%input:
%data         -one sample of test data
%riskMatrix   -risk Matrix 
%meanValue    -the mean matrix ,the first row the mean of positive feature,second row is nagative features mean
%variance     -the variance matrix,the first row the variance of positive feature,second row is nagative features variance
%output:
%result       -the predict of test data
n=length(label);
prior=[double(1/3);double(2/3)];
%first row is positive condition posibility function of features
%second row is nagetive condition posibility function of features
CondP=[(1/((2*pi)^(1/2)*variance(1,1)^2))*exp(-(data(1)-meanValue(1,1)).^2/(2*variance(1,1)^2)),  ( 1/((2*pi)^(1/2)*variance(1,2)^2))*exp(-(data(2)-meanValue(1,2)).^2/(2*variance(1,2)^2));
(1/((2*pi)^(1/2)*variance(2,1)^2))*exp(-(data(1)-meanValue(2,1)).^2/(2*variance(2,1)^2)),(1/((2*pi)^(1/2)*variance(2,2)^2))*exp(-(data(2)-meanValue(2,2)).^2/(2*variance(2,2)^2))];
[m,k]=size(CondP);
condMatrix=ones(1,m);
for i=1:m
    for j=1:k
        condMatrix(i)=condMatrix(i)*CondP(i,j);
    end
    condMatrix(i)=condMatrix(i)*prior(i);
end
condValue=[condMatrix;condMatrix];
condValue=condValue.*risk;
for i=1:m
    condMatrix(i)=sum(condValue(i,:));
end

[maxValue,result]=min(condMatrix);
if result==1%because the label is 0 or 1,but index is 1 or 2
    result=1;
else
    result=0;
end
end