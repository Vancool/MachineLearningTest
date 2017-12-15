function result=Ent(dataSet,posibility)
    %count one feature's Ent(D),data is data,posibility is labels
	%get Ent(D)
	y=length(posibility);%get the size of posibility£¨label£©
	n=size(dataSet,1);%get the size of data set(one col)
	result=0;
	%count p(k) -the probably of the label is k
	p=[];
	%get the probabaly array
	for i=1:y
		count=0;
		for j=1:n
			if(dataSet(j,5)==i)
				%the sixth particular of the dataSet{i} is the label
				count=count+1;
			end
		end
		p=[p double(count)/double(n)];%updata the probably array
	end
	for i=1:y
        if(p(i)==0)
            %maybe will be NAN
            continue;
        end
		result=result-p(i)*log2(p(i));
	end
end