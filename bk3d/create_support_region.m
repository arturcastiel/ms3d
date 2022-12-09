function [support_region] = create_support_region(pcoarse,boundary_support)
%create_support_region Create the support region itself using an algorithm
%similar to a leakeage test.
global face element
support_region = false(size(boundary_support,1),size(boundary_support,2));
num_inner_faces = size(face.inner.centroid,1);
num_bound_faces = size(face.bound.centroid,1);
list_faces_total = false(num_inner_faces + num_bound_faces,1);
for vol = 1:size(support_region,2)
    water_old = pcoarse.elemloc==vol;
    index = 1;
    while true
        list_faces_total(reshape(element.faces(water_old,:),[],1)) = 1;
        list_faces = list_faces_total(1:num_inner_faces);
        water_new = false(size(water_old ));
        water_new(face.inner.montelem(list_faces)) = true;
        water_new(face.inner.juselem(list_faces)) = true;
        water_new(boundary_support(:, vol)) = false;
        if all(water_old == water_new) 
            break
        end
        water_old = water_new;
        index = index + 1;
    end
    support_region(:,vol) = water_new;
end
end