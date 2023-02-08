function writte_attribute(xmf,prop,prop_name)
    fprintf(xmf,'<Attribute Name="%s" AttributeType="Scalar" Center="Cell">\n',prop_name);
    fprintf(xmf,'<DataItem Dimensions="%d" NumberType="Float" Precision="8" Format="HDF">\n',size(prop,1));
    fprintf(xmf, 'props.h5:/%s\n',prop_name);
    fprintf(xmf,'</DataItem>\n');
    fprintf(xmf,'</Attribute>\n');
end