function result=countIV(lessSet,moreSet)
	n=size(lessSet,1)+size(moreSet,1);%dataSet size
	moreNum=size(moreSet,1);
	lessNum=size(lessSet,1);
	if(size(lessSet,1)==0)
		result=0;
		return
	end
	if(size(moreSet,1)==0)
		result=0;
		return
	end
	result=-lessNum/n*log2(lessNum/n)-moreNum/n*log2(moreNum/n);

end