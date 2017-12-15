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
%Cross-validation
%get 5 different kinds of test sets and training sets
testNumber=(size1+size2+size3)/5;
trainNumber=size1+size2+size3-testNumber;

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

TestSetMatrix=cell(5,1);
TrainSetMatrix=cell(5,1);
ValidationMatrix=cell(5,1);
	%group sampling
    %one label data
indice1=crossvalind('Kfold',size1,5);
indice2=crossvalind('Kfold',size2,5);
indice3=crossvalind('Kfold',size3,5);
%because ID3 tree without prune is not require validation set
%it's test matrix is different with a pruning tree 


for i=1:5
    
    trainData=[];
    testData=[];
    validData=[];
    trainDataP=[];
    test=(indice1==i);
    train=~test;
    trainData1=oneMatrix(train,:);
    testData=oneMatrix(test,:);
    trainDataP=trainData1;
    m=size(trainData1,1);
    %using the Retention method to get validation matrix from data
    %   25%*80% validation data 75%*80%training data
    %   20% test data
    indice11=crossvalind('Kfold',m,5);
    valid=(indice11==1);
    train=~valid;
    trainData=trainData1(train,:);
    validData=trainData1(valid,:);
    
    
    
    test=(indice2==i);
    train=~test;
    trainData2=twoMatrix(train,:); 
    testData=[testData;twoMatrix(test,:)];
     m=size(trainData2,1);
    indice11=crossvalind('Kfold',m,5);
    valid=(indice11==1);
    train=~valid;
    validData=[validData;trainData2(valid,:)];
    trainData=[trainData;trainData2(train,:);];
   
    
    
    test=(indice3==i);
    train=~test;
    trainData3=threeMatrix(train,:); 
    testData=[testData;threeMatrix(test,:)];

     m=size(trainData3,1);
    indice11=crossvalind('Kfold',m,5);
    valid=(indice11==1);
    train=~valid;
    validData=[validData;trainData3(valid,:)];
    trainData=[trainData;trainData3(train,:);];
    %get validation matrix
    TestSetMatrix{i}=testData;
    TrainSetMatrix{i}=trainData;
    ValidationMatrix{i}=validData; 

end
save TrainSetMatrix TrainSetMatrix
save TestSetMatrix TestSetMatrix
save ValidationMatrix ValidationMatrix







