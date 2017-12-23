function result=getTreeLabel(tree,data)
currentFeature=tree.feature;
currentValue=tree.value;
if(currentFeature=='0')
	result=currentValue;
	return
else
    if(data(currentFeature)<currentValue)
        result=getTreeLabel(tree.left,data);
    else
        result=getTreeLabel(tree.right,data);
    end
end