function [face_source] = create_face_source_terms(face, flagstruct)
num_inner_faces = size(face.inner.centroid,1);
num_bound_faces = size(face.bound.centroid,1);
face_source = sparse(num_bound_faces + num_inner_faces,1);
ref_i = false(num_inner_faces,1);
for index = 1:size(flagstruct.flag_value_neuman,1)
    bc = flagstruct.flag_value_neuman(index,1);
    val = flagstruct.flag_value_neuman(index,2); 
    ref_b = face.bound.flag == bc;
    areas = face.bound.area(ref_b);
    total_areas = sum(areas);
    areas = areas ./ total_areas;
    ref = [ref_i ; ref_b];
    face_source(ref) = areas .* val;    
end
end