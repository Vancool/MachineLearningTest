function result=getGainRatio(gainResult,lessSet,moreSet)
IVResult=countIV(lessSet,moreSet);
if IVResult==0
	result=inf;
else
	result=gainResult/IVResult;
end
end