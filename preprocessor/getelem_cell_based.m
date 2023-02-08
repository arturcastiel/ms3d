function [elem,elem_flag,bedgeref,nflag] = getelem_cell_based(filepath,...
                                            nnode, preconfig)
%Open the *.msh file
readmsh = fopen(filepath);
nflag = zeros(nnode,1);
%"nent" is the number of all entities in *.msh file
getmshdata = textscan(readmsh,'%u',1,'HeaderLines',7 + nnode);
%Attribute the data to "nnode"
nent = getmshdata{1};
readmsh = fopen(filepath);
H1 = 8 + nnode;
getmshdata  = textscan(readmsh,'%u %u %u %u %u %u %u %u %u %u', ...
     nent,'HeaderLines',H1, 'CommentStyle','$', 'Delimiter', {'\r',' '}, 'EndOfLine','\r\n');  
fclose(readmsh);
elem_data = cell2mat(getmshdata);
elem_data = elem_data(:,~all(elem_data == 0));

tri_faces_ref = elem_data(:,2) == 2;
tetrahedron_vol_ref = elem_data(:,2) == 4;

tri_faces = elem_data(tri_faces_ref,:);
tri_faces = tri_faces (:,~all(tri_faces == 0));

tetrahedron_vol = elem_data(tetrahedron_vol_ref,:);
tetrahedron_vol = tetrahedron_vol(:,~all(tetrahedron_vol == 0));

elem_flag = tetrahedron_vol(:,4);
elem = tetrahedron_vol(:,end-3:end);

bedgeref = zeros(size(tri_faces,1),5);
bedgeref(:,1:3) = tri_faces(:,end-2:end);
bedgeref(:,end) = tri_faces(:,4);

%make dirichlet boundaries have priority
nflag(bedgeref(:,1)) = bedgeref(:,end);
nflag(bedgeref(:,2)) = bedgeref(:,end);
nflag(bedgeref(:,3)) = bedgeref(:,end);

if preconfig.sort_symrcm
    disp("Sorting mesh element using symrcm")
    [elem,~] = sort_elem_symrcm(elem);
end
end