file=dir('trainingDigits/*.txt');%batch read the file,train data
TrainDataSize=length(file);
TrainDataLabel=zeros(TrainDataSize,1);
%use regular expression to get label
for i=1:TrainDataSize
	name=file(i).name;
	ms=regexp(name,'[0-9]','match');
	TrainDataLabel(i)=str2num(ms{1});%ms is cell
end
save TrainDataLabel
fileTest=dir('testDigits/*.txt');%the same way 
TestDataSize=length(fileTest);
for i=1:TestDataSize
	name=fileTest(i).name;
	ms=regexp(name,'[0-9]','match');
	TestDataLabel(i)=str2num(ms{1});%ms is cell
end
save TestDataLabel