function [summation] = create_summation_operator(mesh)
% definition of the summation operator responsible for mass divergent of
% the unique flux ensuring mass conservation.
len_inedge = size(mesh.face.inner.centroid,1);
len_bedge = size(mesh.face.bound.centroid,1);
length = len_bedge + len_inedge;
auxmat1 = [mesh.face.inner.upstream [1:len_inedge]' ones(len_inedge,1)];
auxmat2 = [mesh.face.inner.downstream [1:len_inedge]' -ones(len_inedge,1)];
auxmat3 = [mesh.face.bound.upstream ([1:len_bedge]' + len_inedge) ...
                                                        ones(len_bedge,1)];
auxmat = [auxmat1; auxmat2; auxmat3];
summation = sparse(auxmat(:,1), auxmat(:,2) ,auxmat(:,3), ...
                                size(mesh.element.centroid,1), length);
end
