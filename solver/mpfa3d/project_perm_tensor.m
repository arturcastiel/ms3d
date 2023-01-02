function [project_perm] = project_perm_tensor(normals, perm, areas)
    nx = normals(:,1);
    ny = normals(:,2);
    nz = normals(:,3);
    a = perm(:,1);
    b = perm(:,2);
    c = perm(:,3);
    d = perm(:,4);
    e = perm(:,5);
    f = perm(:,6);
    g = perm(:,7);
    h = perm(:,8);
    i = perm(:,9);
    project_perm = nx.*(a.*nx + d.*ny + g.*nz) + ...
        ny.*(b.*nx + e.*ny + h.*nz) + nz.*(c.*nx + f.*ny + i.*nz);
    project_perm = project_perm./ (areas.*areas);
end