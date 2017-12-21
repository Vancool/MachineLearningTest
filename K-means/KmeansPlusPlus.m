function result=KmeansPlusPlus(k,data)
%find better center,k-mean++ method
%input:
%	k 		-find k center point 
%	data 	-the data set
%output:
%	result 	-the center point

[m,n]=size(data);
index=randi([1 m]);
result=zeros(k,n);
result(1,:)=data(index,:);
dis=zeros(m,1);
for i=1:m
	dis(i)=inf;
end
for j=2:k
	for i=1:m
		dis(i)=inf;
	end
	for i=1:m
		for z=1:j
			if(dis(i)>norm(result(z,:)-data(i,:))^2)
                %find the minimum distance
				dis(i)=norm(result(z,:)-data(i,:))^2;
			end
		end
	end
	sumValue=sum(dis);
	[maxval,index]=max(dis/sumValue);
	result(j,:)=data(index,:);
end

end