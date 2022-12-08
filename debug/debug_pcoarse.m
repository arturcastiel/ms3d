global element face
for el = 1:max(pcoarse.elemloc)
    nodes = bkgrid.elem(el,:);
    el_coord = bkgrid.coord(nodes,:);
    box_el_coord = [min(el_coord); max(el_coord)];
    coarse_ref = pcoarse.elemloc == el;
    coarse_coord = element.centroid(coarse_ref,:);
    box_coarse_coord = [min(coarse_coord); max(coarse_coord)];
    tol= 10^-2;
    ref_max = box_el_coord(1,:) - box_coarse_coord(1,:) <= tol;
    ref_min = box_el_coord(2,:) - box_coarse_coord(2,:) >= -tol;
    if all(ref_min & ref_max)
        disp(num2str(el) + " pcoarse calculated with success.")
    else
        disp("Error at pcoarse element " + num2str(el) + ".")
    end
end

num_inner_face = size(face.inner.centroid,1);
for index_face = 1:size(pcoarse.faces,2)
    neigh_el = bkgrid.face_neighbours(index_face,:);
    analysed_faces = pcoarse.faces(:,index_face);
    internal_faces = analysed_faces(1:num_inner_face);
    boundary_faces = analysed_faces(num_inner_face+1:end);
    num_if = sum(internal_faces);
    num_bf = sum(boundary_faces);
    if bkgrid.bfaces(index_face)
      fprintf("Face %d. Type: Boundary face.\n", index_face)
    else
      fprintf("Face %d. Type:  Internal face.\n", index_face)
    end
    fprintf("Number of fine-scale internal faces in coarse ..." + ...
        "face %d: %d\n",index_face,num_if)
    fprintf("Number of fine-scale boundary faces in coarse ..." + ...
        "face %d: %d\n",index_face,num_bf)
    if neigh_el(2) == 0
       if num_if ~= 0
          fprintf("ERROR: number of internal faces > 0\n");
       end
       analysed_elements = face.bound.montelem(boundary_faces,:);
       if all(pcoarse.elemloc(analysed_elements) == neigh_el(1))
           fprintf("Pcoarse face %d respect bkgrid.face and neighbours. \n",...
               index_face)
       else
           fprintf("ERROR: Pcoarse face %d does not respect bkgrid.face "...
               + "and neighbours.\n",index_face)
       end
    else
       analysed_elements = ...
           [face.inner.montelem(internal_faces,:) ...
           face.inner.juselem(internal_faces,:)];
       analysed_elements = pcoarse.elemloc(analysed_elements);
       ref = all(ismember(analysed_elements,neigh_el),2);
       if num_bf ~= 0
          fprintf("ERROR: number of boundary faces > 0\n");
       end

       if all(ref)
           fprintf("Pcoarse face %d respect bkgrid.face and neighbours. \n",...
               index_face)
       else
           fprintf("ERROR: Pcoarse face %d does not respect bkgrid.face "...
               + "and neighbours.\n",index_face)
       end
    end
end

cv_coarse = [1:size(bkgrid.elem,1)];
cv_coarse_cand = unique(pcoarse.elemloc(pcoarse.centers))';
if all(cv_coarse == cv_coarse)
    disp("Coarse Volumes created succesfully.")
else
    disp("ERROR: Coarse volumes with problem.")
end


