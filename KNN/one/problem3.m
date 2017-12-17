%change the distance and voting ways
accMatrix=cell(3,2);
for k=1:2:21
    for i=1:3
        for j=1:2
  
           accMatrix{i,j}=[accMatrix{i,j} handWritingWithKNNs(k,[i j])] ;
        end
    end
end
k=1:2:21;
for i=1:3
    for j=1:2
        if(i==2&&j==1) 
            plot([1:2:21],accMatrix{2,1},'-*');
            hold on
        else
            plot(k,accMatrix{i,j},'-o');
            hold on
        end
    end
end
xlabel('k')
ylabel('accuracy %')
title('accuracy gragh with different distance & voting weight')
legend('Euclidean distance && voting without weight','Euclidean distance && 1/(distance)^2','Manhattan Distance && voting without weight','Manhattan Distance && 1/(distance)^2','Cosine similarity && voting without weight','Cosine similarity &&similarity');
