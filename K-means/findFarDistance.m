function result=findFarDistance(k,data)
%find better center
%input:
%	k		-find k center point
% 	data	-the data set
%output:
%	result	-the center point
	
	[m,n]=size(data);
	index=randi([1 m]);%random select the first point
	result=zeros(k,n);
	result(1,:)=data(index,:);
	dis=zeros(m,1);
	for i=2:k
		for j=1:m
			currentResult=result;
			currentResult(i,:)=data(j,:);
			dis(j)=max(sum((currentResult-result).^2));
		end
		[maxValue,indexK]=max(dis);
		result(i,:)=data(indexK,:);
	end
end