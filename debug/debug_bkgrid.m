


for el = 1:size(size(bkgrid.elem,1))
%faces tests    
nod = unique(bkgrid.elem(el,:));
fac = unique(bkgrid.elem_faces(el,:))';
nfac = unique(bkgrid.faces_adj(fac,:))';
if all(nod == nfac)
    disp("The nodes of element " + num2str(el) + " and its faces" +  ...
        " adjancies are equal.")
else
    disp("ERROR: The nodes of element " + num2str(el) + " and its faces" ...
        + " adjancies are not equal.")
    break
end

ledges = unique(bkgrid.elem_edges(el,:))';
lnodes = unique(bkgrid.edges(ledges',:))';

if all(lnodes == nod)
    disp("The edges of element " + num2str(el) + " and its edges" +  ...
        " adjancies are equal.")
else
    disp("ERROR: The nodes of element " + num2str(el) + " and its edges" ...
        + " adjancies are not equal.")
    break
end

calc_coord = mean(bkgrid.coord(nod,:));
if all(calc_coord == bkgrid.element_center(el,:))
    disp("Centre of element: " + num2str(el) + " calculated correctly.")
else
    disp("ERROR: Centre of element: " + num2str(el) + "with error.")
end

for led = ledges'
    cnode = bkgrid.edges(led,:)';
    calc_lcoord = mean(bkgrid.coord(cnode,:));
    if all(calc_lcoord == bkgrid.edge_centers(led,:))
        disp("Centre of edge: " + num2str(led) + " calculated correctly.")
    else
        disp("ERROR: Centre of edge: " + num2str(led) + " with error.")
        break
    end
end


for cface = fac'
    cnode = bkgrid.faces_adj(cface,:)';
    calc_fcoord = mean(bkgrid.coord(cnode,:));
    if all(calc_fcoord == bkgrid.face_center(cface,:))
        disp("Centre of face: " + num2str(cface) + " calculated correctly.")
    else
        disp("ERROR: Centre of face: " + num2str(cface) + " with error.")
        break
    end
end
end
internal_neigh_matrix = bkgrid.face_neighbours(~bkgrid.bfaces,:);

for ii = internal_neigh_matrix'
shared_face = intersect(bkgrid.elem_faces(ii(1),:),bkgrid.elem_faces(ii(2),:));
if ~isempty(shared_face)
    disp(mat2str(ii) + "Internal bkface neighbours correctly calculated. ")
else
    disp("Error on neighbours bkface.")
    break
end
end

disp("No errors found at the analysed background grid.")

