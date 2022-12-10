function create_bkgrid_msh_file(coord,elem,file_name,folder)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if isstring(folder)
    folder = fullfile(pwd, folder);
else
    folder = fullfile(pwd,"Results");
end
if ~isfolder(folder)
    mkdir(folder);
end
extension = '.msh';
file_path = fullfile(folder,file_name+extension );

num_coord = size(coord,1);
gmsh_coord = [[1:num_coord]' coord];
num_elem = size(elem,1);
gmsh_elem = [[1:num_elem]' 5*ones(num_elem,1) 2*ones(num_elem,1) ... 
    ones(num_elem,1) ones(num_elem,1) elem];
fid = fopen(file_path,'w'); 
%Writing header informations
fprintf(fid,'$MeshFormat\n');
fprintf(fid,'2.2 0 8\n');
fprintf(fid,'$EndMeshFormat\n');
%Writing node information
fprintf(fid,'$Nodes\n');
fprintf(fid,'%d\n',num_coord);
fprintf(fid,'%d %f %f %f  \r\n',gmsh_coord');
fprintf(fid,'$EndNodes\n');
fprintf(fid,'$Elements\n');
fprintf(fid,'%d\n',num_elem);
fprintf(fid,'%d %d %d %d %d %d %d %d %d %d %d %d %d\r\n',gmsh_elem');
fprintf(fid,'$EndElements\n');
fprintf(fid,'$EndMeshFormat\n');    
%Information about grid type
fclose(fid);
end