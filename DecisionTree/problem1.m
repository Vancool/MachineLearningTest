%make tree
clear
load('TrainSetMatrix.mat');
load('TestSetMatrix.mat')
accuracy=0;
for i=1:5
    currentTestMatrix=TestSetMatrix{i};
    currentTrainMatrix=TrainSetMatrix{i};
    [partitionMatrix,activePartMatrix]=makePartitionMatrix(currentTrainMatrix);
    tree=ID3Tree(currentTrainMatrix,partitionMatrix,activePartMatrix,[1 2 3]);
    testNum=size(currentTestMatrix,1);
    errorNum=0;
    for j=1:testNum
        result=findLabel(tree,currentTestMatrix(j,:));
        if(result~=currentTestMatrix(j,5))
            errorNum=errorNum+1;
        end
    end
    accuracy=accuracy+double(errorNum)/double(testNum);
end
disp('ID3 tree without pruning')
accuracy=100-accuracy/5*100