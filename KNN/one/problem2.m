a=[];
k=1:2:50;
for i=1:2:50
    a=[a handWriting(i)];
end
plot(k,a,'-o');
xlabel('k');
ylabel('accuracy %');
str=[num2str(a')];
text(k,a,cellstr(str(:,1:4)));
