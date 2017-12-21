function result=getAverageCenter(A)
%to compare every mean vector and find the average mean vector
%using greedy method
%input:
%		A 		-one cell matrix including all mean vector matrix
%output:
%		result	-the average mean vector
N=length(A);
[n,m]=size(A{1});
result=zeros(n,m);
for i=1:n
	currentVector=A(i,:);
	minNorm=inf;
	for j=1:n
		if(minNorm>norm(currentVector-B(j,:)))
			minNorm=
		end
	end
end


end