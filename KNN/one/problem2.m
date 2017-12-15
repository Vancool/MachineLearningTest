a=[];
k=1:100;
for i=1:100
    a=[a handWriting(i)];
end
plot(k,a,'-o');
xlabel('k');
ylabel('accuracy %');
str=[num2str(a')];
text(x,y,cellstr(str));
