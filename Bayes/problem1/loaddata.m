[buying,maint,door,Persons,Lug_boot,Safety,Label]= textread('car evaluation dataset.txt','%s%s%s%s%s%s%s','delimiter',',');
n=length(Label);
data=zeros(n,7);
%the meaning of data Matrix
%buying 
%v-high   1
%high     2  
%med      3
%low      4
%*****************************%
%maint    
%v-high   1
%high     2
%med      3
%low      4
%*****************************%
%door
%2        1
%3        2
%4        3
%5-more   4
%*****************************%
%persons
%2        1
%4        2
%more     3
%*****************************%
%Lug_boot
%small    1
%med      2
%big      3
%*****************************%
%safety
%low      1
%med      2
%high     3
%*****************************%
%Label    
%unacc    1
%acc      2
%good     3
%V-good   4
%*****************************%
for i=1:n
	buy=0;
	if strcmp(buying{i},'v-high')
			buy=1;
			elseif strcmp(buying{i},'high')
			buy=2;
			elseif strcmp(buying{i},'med')
			buy=3;
			else	
			buy=4;
	end
	maintt=0;
	if strcmp(maint{i},'v-high')
			maintt=1;
			elseif strcmp(maint{i},'high')
			maintt=2;
			elseif strcmp(maint{i},'med')
			maintt=3;
			else	
			maintt=4;
	end
	doorr=0;
	if strcmp(door{i},'2')
			doorr=1;
			elseif strcmp(maint{i},'3')
			doorr=2;
			elseif strcmp(maint{i},'4')
			doorr=3;
			else	
			doorr=4;
	end
	person=0;
	if strcmp(Persons{i},'2')
			person=1;
			elseif strcmp(Persons{i},'4')
			person=2;
			else	
			person=3;
	end
	lugboot=0;
	if strcmp(Lug_boot{i},'small')
			lugboot=1;
			elseif strcmp(Lug_boot{i},'med')
			lugboot=2;
			else	
			lugboot=3;
	end
    safe=0;
	if strcmp(Safety{i},'small')
			safe=1;
			elseif strcmp(Safety{i},'med')
			safe=2;
			else	
			safe=3;
	end
	label=0;
	if strcmp(Label{i},'unacc')
			label=1;
			elseif strcmp(Label{i},'acc')
			label=2;
			elseif strcmp(Label{i},'good')
			label=3;
			else	
			label=4;
	end
	data(i,1)=buy;
	data(i,2)=maintt;
	data(i,3)=doorr;
	data(i,4)=person;
	data(i,5)=lugboot;
	data(i,6)=safe;
	data(i,7)=label;		
end
save data