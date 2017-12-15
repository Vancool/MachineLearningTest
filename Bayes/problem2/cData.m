%create data
%positive samples
label=ones(1000,1);
x1= normrnd(1, 2, 1000, 1);
x2=normrnd(3,2,1000,1);
data=[x1,x2,label];
%nagetive samples
label=zeros(2000,1);
x1= normrnd(10, 10, 2000, 1);
x2=normrnd(20,10,2000,1);
data2=[x1,x2,label];
data=[data;data2];
%risk array
RW=[0 0.6; 0.4 0];
%min error rate risk array
ER=[0 1;1 0];
meanMatrix=[1,3; 10,20];
varianceMatrix=[2,2; 10,10];

