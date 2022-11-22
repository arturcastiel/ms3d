function [nelemloc] = ensure_face_connectivity(elemloc)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%global face element inedge elem
global face element
nel = size(element.centroid,1);
npar = max(elemloc);
inedge = [face.inner.juselem face.inner.montelem];
nelemloc = elemloc;
bad_elements = [];
for ii = 1:npar
    lref = (elemloc == ii);
    transvec = find(lref);
    transback = zeros(nel,1);
    transback(transvec) = 1:size(transvec,1);
    edge_ref = all(ismember( inedge(:,1:2), transvec),2);
    auxmat = transback(inedge(edge_ref,1:2));
    G = graph(auxmat(:,1), auxmat(:,2));
    color_coarse =  conncomp(G);
    if max(color_coarse) ~= 1
        [a, b] = hist(color_coarse, unique(color_coarse));
        unconnected_pieces = b(~(a == max(a)));
        ref = ismember(color_coarse, unconnected_pieces);
        bad_elements = [bad_elements; transvec(find(ref))];
    end
end
for ii = bad_elements'
    auxmat = inedge(any(inedge(:,1:2) == ii,2),1:2);
    auxvec =  reshape(auxmat.',1,[]);
    auxvec =  elemloc(auxvec(auxvec ~= ii));
    [a, b] = hist(auxvec, unique(auxvec));
    ref = a == max(a);
    if all(ref)
        ref(:) = false;
        ref(1) = true;
    end
    color = b(ref);
    nelemloc(ii) = color;
end
end
