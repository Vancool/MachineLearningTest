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
            maxValue=0;
			for z=1:i-1
                if(maxValue<norm(result(z,:)-data(j,:)))
                	maxValue=norm(result(z,:)-data(j,:));
                end
            end
            dis(j)=maxValue;
		end
		[~,indexK]=max(dis);
		result(i,:)=data(indexK,:);
	end
end