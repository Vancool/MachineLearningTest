clc,clear
load('trainData.mat');
[n,m]=size(trainData);
%%mean vector using findFarDistance
	pre1=[];%sum(dis^2)
	pre2=[];%average class radius
    pre3=[];%between-class scatter
    pre4=[];%separtion criterion
	for k=2:10
		center=findFarDistance(k,trainData);
		[res,performance]=myKmeans(k,trainData,center,10^5,10^(-5));
		pre1=[pre1 performance(1)];
		pre2=[pre2 performance(2)];
        pre3=[pre3 performance(3)];
        pre4=[pre4 performance(4)];
	end
	k=[2:1:10];
	figure('name','mean vector using findFarDistance')
	hold on
	subplot(411)
	plot(k,pre1,'r-*','MarkerSize',10);
	title('k-sum(distance^2)  gragh')
    xlabel('k');
    ylabel('sum');
    str=[num2str(pre1')];
    text(k,pre1,cellstr(str(:,1:6)));

	subplot(412)
	plot(k,pre2,'b-o','MarkerSize',10)
	title('k-average radius  gragh')
    xlabel('k');
    ylabel('radius');
    str=[num2str(pre2')];
    text(k,pre2,cellstr(str(:,1:6)));
    
      subplot(413)
	plot(k,pre3,'g-o','MarkerSize',10)
	title(' k - betweenclass scatter radius  gragh')
    xlabel('k');
    ylabel('between-class scatter');
    str=[num2str(pre3')];
    text(k,pre3,cellstr(str(:,1:6)));
    
     subplot(414)
	plot(k,pre4,'m-*','MarkerSize',10)
	title('k-separtion criterion  gragh')
    xlabel('k');
    ylabel('separtion criterion');
    str=[num2str(pre4')];
    text(k,pre4,cellstr(str(:,1:6)));


