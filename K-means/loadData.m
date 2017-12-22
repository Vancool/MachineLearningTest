clc
clear
data=importdata('Wine dataset.txt');
[m,n]=size(data);
%normalize data 
for i=2:n
	%find the max feature value and min feature value 
	%limit the value in [0-1]
	dataCol=data(:,i);
	maxValue=max(dataCol);
	minValue=min(dataCol);
	data(:,i)=(dataCol-minValue)/(maxValue-minValue);
end

label=data(:,1);
trainData=data(:,2:end);
save trainData trainData

