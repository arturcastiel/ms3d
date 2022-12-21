function [grown_area] = check_face_limited_growth...
    (mesh, init_region,restriction_region)
%allows the growth using the face adjacencies of of the init_region but
%limited by the restriction region
%similar to a leakeage test.
num_inner_faces = size(mesh.face.inner.centroid,1);
num_bound_faces = size(mesh.face.bound.centroid,1);
list_faces_total = false(num_inner_faces + num_bound_faces,1);
water_old = init_region;
water_old(restriction_region) = false;
index = 1;
while true
    list_faces_total(reshape(mesh.element.faces(water_old,:),[],1)) = 1;
    list_faces = list_faces_total(1:num_inner_faces);
    water_new = false(size(water_old ));
    water_new(mesh.face.inner.upstream(list_faces)) = true;
    water_new(mesh.face.inner.downstream(list_faces)) = true;
    water_new(restriction_region) = false;
    if all(water_old == water_new)
        break
    end
    water_old = water_new;
    index = index + 1;
end
grown_area = water_new;
if sum(grown_area) == sum(~restriction_region)
    error("ERROR: Grown area leaked outside the resitriction region.");
end
end
