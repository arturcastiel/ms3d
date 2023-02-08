function write_xdmf(props, prop_names,scoord, selem, fpath)
    xmf = fopen(fpath, "w");
    fprintf(xmf, '<?xml version="1.0" ?>\n');
    fprintf(xmf, '<!DOCTYPE Xdmf SYSTEM "Xdmf.dtd" []>\n');
    fprintf(xmf, '<Xdmf xmlns:xi="http://www.w3.org/2001/XInclude" Version=\"2.0\">\n');
    fprintf(xmf, " <Domain>\n");
    fprintf(xmf, '   <Grid Name=\"DARSim - Mesh\" GridType=\"Uniform\">\n');
    fprintf(xmf, '     <Topology TopologyType=\"Tetrahedron\" NumberOfElements=\"%d\">\n', selem(1));
    fprintf(xmf, '       <DataItem Format=\"HDF\" Dimensions=\"%d 4\" NumberType="uint64">\n', selem(1));
    fprintf(xmf, '        mesh.h5:/elem\n');
    fprintf(xmf, '       </DataItem>\n');
    fprintf(xmf, '     </Topology>\n');
    fprintf(xmf, '     <Geometry Type=\"XYZ\">\n');
    fprintf(xmf, '       <DataItem Format=\"HDF\" Dimensions=\"%d 3\" NumberType="Float" Precision="8">\n', scoord(1));
    fprintf(xmf, '        mesh.h5:/coords\n');
    fprintf(xmf, '       </DataItem>\n');
    fprintf(xmf, '     </Geometry>\n');
    for index = 1:size(props,2)
     writte_attribute(xmf,props(:,index),prop_names(index))
    end
    fprintf(xmf, '   </Grid>\n');
    fprintf(xmf, ' </Domain>\n');
    fprintf(xmf, '</Xdmf>\n');
fclose(xmf);   
end