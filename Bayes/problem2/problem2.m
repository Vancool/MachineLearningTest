%solve the problem
cData
label=[1 0];
n=size(data,1);
errorNum=0;
%min error rate risk matrix
for i=1:n
	result=rBayes(data(i,:),ER,meanMatrix,varianceMatrix,label);
	if result~=data(i,3)
		errorNum=errorNum+1;
	end
end
disp('min error accuracy:')
accuracy=(1-double(errorNum)/double(n))*100
%risk matrix with different weight
for i=1:n
	result=rBayes(data(i,:),RW,meanMatrix,varianceMatrix,label);
	if result~=data(i,3)
		errorNum=errorNum+1;
	end
end
disp('min risk accuracy:')
accuracy=(1-double(errorNum)/double(n))*100