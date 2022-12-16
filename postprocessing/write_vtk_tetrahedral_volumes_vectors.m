function write_vtk_tetrahedral_volumes_vectors ...
                  (prop,prop_names,folderpath,fname, coord, elem, varargin)
num_element_nodes = 4;
num_properties = size(prop,2)/3;
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
fprintf(fid,'%i \r\n', 10*ones(size(elem,1),1));
fprintf(fid,'CELL_DATA %i \r\n',size(elem,1));
for num_col = 1:num_properties
    ref_last = (num_col*3);
    ref_start = ref_last-2;
    data = prop(:,ref_start:ref_last);
    fprintf(fid,'VECTORS %s float %d \r\n',prop_names(num_col), 1);
    fprintf(fid,'%26.16E %26.16E %26.16E \r\n',full(data)');
    fprintf(fid,'\n');
end
fclose(fid);
end 

