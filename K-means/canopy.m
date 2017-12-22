function [center,k]=canopy(t,data)
%input:
%	t 		-[t1,t2],to split the data
%	data	-the data set
%output:
%	result	-the canopy set
k=0;
%t(1) > t(2)
if(t(1)<t(2))
	temp=t(1);
	t(1)=t(2);
	t(2)=temp;
end
[m,n]=size(data);
index=randi([1 m]);
currentData=data;
currentData(index,:)=[];
dis=zeros(m-1,1);

C{1}=data(index,:);
j=1;
%find the data that
while(~isempty(currentData))
	n=size(currentData,1);
	if j>1
		index=randi([1 n]);
		C{j}=currentData(index,:);
	end
	dis=zeros(n,1);
    deleteSet=[];
	for i=1:n-1
		dis(i)=sum((currentData(i,:)-currentData(index,:)).^2);
		if(dis(i)<t(1))
			C{j}=[C{j};currentData(i,:)];
	    end
		if dis(i)<t(2)
			deleteSet=[deleteSet;i];
        end
    end
    if isempty(deleteSet)
        break;
    end
    currentData(deleteSet,:)=[];
	j=j+1;

end
k=size(C,2);
center=zeros(k,size(data,2));
for i=1:k
    if size(C{i},1)==1
        center(i,:)=C{i};
    else
        center(i,:)=sum(C{i})/size(C{i},1);
    end
    
end


end