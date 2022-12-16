function write_vtk_tetrahedral_faces ...
                  (prop,prop_names,folderpath,fname, coord, elem, varargin)
num_element_nodes = 3;
num_properties = size(prop,2);
if num_properties ~= max(size(prop_names))
     error("ERROR: The number of properties must be equal to the " + ...
                                    "number of properties names.");
end
extension = ".vtk";
if ~isempty(varargin)
    fname = fname +  num2str(varargin{1},'%03.f') + extension;
else
    fname = fname + extension;
end
file_path = fullfile(folderpath,fname);
fid = fopen(file_path,'w'); 
fprintf(fid,'# vtk DataFile Version 2.0\n');
fprintf(fid,['ADMIRE Software - Coded by Dr. Artur Castiel - ' ...
                                                    '16-12-2022\r\n']);
fprintf(fid,'ASCII \r\n');
fprintf(fid,'DATASET UNSTRUCTURED_GRID \r\n\r\n');
fprintf(fid,'POINTS %i float \r\n\r\n',size(coord,1));
fprintf(fid,'%26.16E %26.16E %26.16E \r\n',coord');
fprintf(fid,'CELLS %i %i \r\n\r\n',size(elem,1), ...
                                    size(elem,1)*(num_element_nodes + 1));
fprintf(fid,'%i %i %i %i %i \r\n', ...
                           [num_element_nodes*ones(size(elem,1),1) ...
                                                            (elem -1)]');
fprintf(fid,'CELL_TYPES %i \r\n\r\n',size(elem,1));
fprintf(fid,'%i \r\n', 5*ones(size(elem,1),1));
fprintf(fid,'CELL_DATA %i \r\n',size(elem,1));
for num_col = 1:size(prop,2)
    fprintf(fid,'SCALARS %s float 1 \r\n',prop_names(num_col));
    fprintf(fid,'LOOKUP_TABLE default \r\n\r\n');
    fprintf(fid,'%26.16E \r\n',full(prop(:,num_col)));
end
fclose(fid);
end 

