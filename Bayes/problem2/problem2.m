%solve the problem
cData
label=[1 0];
n=size(data,1);
%min error rate risk matrix
[result accuracy]=rBayes(meanMatrix,prior,convariance,RW,data,label);
disp('min error accuracy:')
accuracy
%risk matrix with different weight
[result accuracy]=rBayes(meanMatrix,prior,convariance,ER,data,label);
disp('min risk accuracy:')
accuracy