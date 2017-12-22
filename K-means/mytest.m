load('trainData.mat');
[n,m]=size(trainData);
%%mean vector using findFarDistance
	pre1=[];%sum(dis^2)
	pre2=[];%average class radius
	for k=2:7
		center=findFarDistance(k,trainData);
		[res,performance]=myKmeans(k,trainData,center,10^5,10^(-5));
		pre1=[pre1 performance(1)];
		pre2=[pre2 performance(2)];
	end
	k=[2:1:7];
	figure('name','mean vector using findFarDistance')
	hold on
	subplot(211)
	plot(k,pre1,'r-*','MarkerSize',10);
	title('k-sum(distance^2)  gragh')
    xlabel('k');
    ylabel('sum');
    str=[num2str(pre1')];
    text(k,pre1,cellstr(str(:,1:6)));
    subplot(212)
	plot(k,pre2,'b-o','MarkerSize',10)
	title('k-average radius  gragh')
    xlabel('k');
    ylabel('radius');
    str=[num2str(pre2')];
    text(k,pre2,cellstr(str(:,1:6)));


    