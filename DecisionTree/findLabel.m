function result=findLabel(tree,data)
currentFeature=tree.feature;
currentValue=tree.value;
if(currentFeature=='0')
	result=currentValue;
	return
else
    if(data(currentFeature)<currentValue)
        result=findLabel(tree.left,data);
    else
        result=findLabel(tree.right,data);
    end
end

