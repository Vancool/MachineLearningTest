%different k and different original mean vector
clc,clear
load('trainData.mat');
[n,m]=size(trainData);

%%random original mean vector without any method
	pre1=[];%sum(dis^2)
	pre2=[];%average class radius
    pre3=[];%between-class scatter
    pre4=[];%separtion criterion
	for k=2:10
		centerIndex=sampling(1:n,k);
		center=trainData(centerIndex,:);
		[res,performance]=myKmeans(k,trainData,center,10^5,10^(-5));
		pre1=[pre1 performance(1)];
		pre2=[pre2 performance(2)];
        pre3=[pre3 performance(3)];
        pre4=[pre4 performance(4)];
	end
	k=[2:1:10];
	figure('name','random original mean vector without any method')
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc,clear
load('trainData.mat');
[n,m]=size(trainData);
%%iterate 100 times to find well clusting
	per1=[];%sum(dis^2)
	per2=[];%average class radius
    per3=[];%between-class scatter
	per4=[];  %separtion criterion
	for k=2:10
		minPer1=inf;
		minper2=inf;
		result={};
		for i=1:100
			centerIndex=sampling(1:n,k);
			center=trainData(centerIndex,:);
			[res,performance]=myKmeans(k,trainData,center,10^5,10^(-5));
			if performance(1)<minPer1
				minPer1=performance(1);
				minper2=performance(2);
                minper3=performance(3);
                minper4=performance(4);
				result=res;
			end
		end
		
		per1=[per1 minPer1];
		per2=[per2 minper2];
        per3=[per3 minper3];
        per4=[per4 minper4];
	end
	k=[2:1:10];
	figure('name','iterate 100 times to find well clusting')
	hold on
	subplot(411)
	plot(k,per1,'r-*','MarkerSize',10);
	title('k-sum(distance^2)  gragh')
    xlabel('k');
    ylabel('sum');
    str=[num2str(per1')];
    text(k,per1,cellstr(str(:,1:6)));

	subplot(412)
	plot(k,per2,'b-o','MarkerSize',10)
	title('k-average radius  gragh')
    xlabel('k');
    ylabel('radius');
    str=[num2str(per2')];
    text(k,per2,cellstr(str(:,1:6)));
    
    subplot(413)
	plot(k,per3,'g-o','MarkerSize',10)
	title(' k - betweenclass scatter radius  gragh')
    xlabel('k');
    ylabel('between-class scatter');
    str=[num2str(per3')];
    text(k,per3,cellstr(str(:,1:6)));
    
     subplot(414)
	plot(k,per4,'m-*','MarkerSize',10)
	title('k-separtion criterion  gragh')
    xlabel('k');
    ylabel('separtion criterion');
    str=[num2str(per4')];
    text(k,per4,cellstr(str(:,1:6)));





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc,clear
load('trainData.mat');
[n,m]=size(trainData);
%%mean vector using k-mean++
	pre1=[];%sum(dis^2)
	pre2=[];%average class radius
    pre3=[];%between-class scatter
    pre4=[];%separtion criterion
	for k=2:10
		center=KmeansPlusPlus(k,trainData);
		[res,performance]=myKmeans(k,trainData,center,10^5,10^(-5));
		pre1=[pre1 performance(1)];
		pre2=[pre2 performance(2)];
        pre3=[pre3 performance(3)];
        pre4=[pre4 performance(4)];
	end
	k=[2:1:10];
	figure('name','using k-mean++')
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc,clear
load('trainData.mat');
[n,m]=size(trainData);
%%using bi-kmeans and don't set an original mean vector
	pre1=[];%sum(dis^2)
	pre2=[];%average class radius
    pre3=[];%between-class scatter
    pre4=[];%separtion criterion
	for k=2:10
		[res,performance]=biKmeans(k,trainData);
		pre1=[pre1 performance(1)];
		pre2=[pre2 performance(2)];
        pre3=[pre3 performance(3)];
        pre4=[pre4 performance(4)];
	end
	k=[2:1:10];
	figure('name','bi-kmeans')
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc,clear
load('trainData.mat');
disp('canopy before k-means:');
[n,m]=size(trainData);
%%using canopy method to decide k and center before k-means
	[center,k]=canopy([1.8 1.5],trainData);
	[res,performance]=myKmeans(k,trainData,center,10^5,10^(-5));
	disp('sum(distance^2):')
	performance(1)
	disp('average radius')
	performance(2)
    disp('between-class scatter:')
    performance(3)
    disp('separtion criterion:')
    performance(4)

	
	



