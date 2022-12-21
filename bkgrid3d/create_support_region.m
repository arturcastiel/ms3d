function [support_region] = create_support_region(bkgrid, mesh, ...
                                        sub_volumes,boundary_support)
%create_support_region Create the support region.
support_region = false(size(boundary_support,1),size(boundary_support,2));
for vol = 1:size(support_region,2)
    nodes_ref = bkgrid.elem(vol,:);
    support_region(:,vol) = check_face_limited_growth(mesh, ...
        any(sub_volumes(:,nodes_ref),2), boundary_support(:,vol));
end
end