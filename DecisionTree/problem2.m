%using post-pruning ID3 tree to predict the label
%and count the accuracy
clear
load('TrainSetMatrix.mat');
load('TestSetMatrix.mat');
load('ValidationMatrix.mat');
accuracy=0;
for i=1:5
    currentTestMatrix=TestSetMatrix{i};
    currentTrainMatrix=TrainSetMatrix{i};
    currentValidationMatrix=ValidationMatrix{i};
    %sort the matrix find the feature's partition
    [partitionMatrix,activePartMatrix]=makePartitionMatrix(currentTrainMatrix);
    tree=postpruningID3(currentTrainMatrix,partitionMatrix,activePartMatrix,[1 2 3],currentValidationMatrix);
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
disp('post-pruning ID3 tree')
accuracy=100-accuracy/5*100


