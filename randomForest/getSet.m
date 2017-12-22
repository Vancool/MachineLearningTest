clear
d=importdata('iris.data');
data=cell(length(d),1);%data -cell(1*5) in cell(150*1)
size1=0;
size2=0;
size3=0;
%number label 1-Iris-setosa
%      2-Iris-versicolor
%      3-Iris-virginica
data1=cell(50,1);
data2=cell(50,1);
data3=cell(50,1);
for i=1:length(d)
	data{i}=regexp(d{i},',','split');
	if strcmp(data{i}{5},'Iris-setosa')
		data{i}{6}=1;
		size1=size1+1;
		data1{size1}=data{i};   	
	elseif strcmp(data{i}{5},'Iris-versicolor')
		data{i}{6}=2;
		size2=size2+1;
		data2{size2}=data{i};
	else
		data{i}{6}=3;
		size3=size3+1;
		data3{size3}=data{i};
	end
	
end
%now the cell have 4 features ,1 string label ,1 number label


%transform the cell data into matrix
oneMatrix=zeros(size1,5);
twoMatrix=zeros(size2,5);
threeMatrix=zeros(size3,5);
for i=1:size1
    for j=1:5 
        if j==5
            oneMatrix(i,5)=data1{i}{6};
        else
              oneMatrix(i,j)=str2num(data1{i}{j});
        end
      
       
    end
end
for i=1:size2
    for j=1:5   
        if j==5
            twoMatrix(i,5)=data2{i}{6};
        else
            twoMatrix(i,j)=str2num(data2{i}{j}); 
        end
       
    
    end
end
for i=1:size3
    for j=1:5
    
        if j==5
            threeMatrix(i,5)=data3{i}{6};
        else
            threeMatrix(i,j)=str2num(data3{i}{j});
        end
    end
end








