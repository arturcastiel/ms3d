function write_mesh_hf5(coords,elem,folder)
fileName = fullfile(folder,'mesh.h5');
if isfile(fileName)
    delete(fileName)
end
h5create(fileName , '/elem', [size(elem,2) size(elem,1)],'Datatype','uint64');
h5create(fileName , '/coords', [size(coords,2) size(coords,1)]);
h5write(fileName, '/elem', uint64(elem' - 1));
h5write(fileName, '/coords',coords');
end