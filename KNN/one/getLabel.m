file=dir('trainingDigits/*.txt');%batch read the file,train data
TrainDataSize=length(file);
TrainDataLabel=zeros(TrainDataSize,1);
trainData=cell(TrainDataSize,1);
%use regular expression to get label
for i=1:TrainDataSize
	name=file(i).name;
	ms=regexp(name,'[0-9]','match');
	TrainDataLabel(i)=str2num(ms{1});%ms is cell
end
for i=1:TrainDataSize
    fid=fopen(['trainingDigits/',file(i).name],'r');
    traindata=fscanf(fid,'%s');
    data=zeros(32,32);
    for j=1:32
        for z=1:32
            data(j,z)=str2num(traindata((j-1)*32+z));
        end
    end
    trainData{i}=data;
    fclose(fid);
end
save trainData trainData
save TrainDataLabel TrainDataLabel
fileTest=dir('testDigits/*.txt');%the same way 
TestDataSize=length(fileTest);
for i=1:TestDataSize
	name=fileTest(i).name;
	ms=regexp(name,'[0-9]','match');
	TestDataLabel(i)=str2num(ms{1});%ms is cell
end
save TestDataLabel TestDataLabel
testData=cell(TestDataSize,1);
for i=1:TestDataSize
    fid=fopen(['testDigits/',fileTest(i).name],'r');
    testdata=fscanf(fid,'%s');
    data=zeros(32,32);
    for j=1:32
        for z=1:32
            data(j,z)=str2num(testdata((j-1)*32+z));
        end
    end
    testData{i}=data;
    fclose(fid);
end
save testData testData