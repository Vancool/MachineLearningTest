load('data.mat');
result=[];
%the first 200
disp('200 training data')
accuracy=NBayesTest(200,data,[4 4 4 3 3 3 4])
result=[result accuracy];
%the first 500
disp('500 training data')
accuracy=NBayesTest(500,data,[4 4 4 3 3 3 4])
result=[result accuracy];
%the first 700
disp('700 training data')
accuracy=NBayesTest(700,data,[4 4 4 3 3 3 4])
result=[result accuracy];
%the first 1000
disp('1000 training data')
accuracy=NBayesTest(1000,data,[4 4 4 3 3 3 4])
result=[result accuracy];

%the first 1350
disp('1350 training data')
accuracy=NBayesTest(1350,data,[4 4 4 3 3 3 4])
result=[result accuracy];
title('accuracy curve')
xlabel('number of train data')
ylabel('accuracy %')
hold on
plot([200,500,700,1000,1350],result,'-o');


