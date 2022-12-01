function wells = calcwellsspeed( element, vertex )
%
% ref_dirch_node = vertex.flag;
nodes_reference = vertex.flag;
nodes_reference(nodes_reference == 5000) = 0;
auxmat = nodes_reference(element.vertices);

ref_dirich_element = any((auxmat < 200) & (auxmat>0),2);
ref_neuman_element = any((auxmat > 200),2);

%% dirichlet bcs have a precedence to  neumman dirichlet bc
ref_neuman_element(ref_dirich_element) = 0;

% flag_val = vertex.flag(ref_dirch_node);
%dirnodes = find(vertex.flag<200);
num_dirichlet = sum(ref_dirich_element);
num_neuman = sum(ref_neuman_element);
%wells = zeros(num_dirichlet + num_neuman ,6);
% 
% 
% for i=1:size(dirnodes,1)
%     no = dirnodes(i);
%     col_1 = find(element.vertices(:,1)==no);
%     col_2 = find(element.vertices(:,2)==no);
%     col_3 = find(element.vertices(:,3)==no);
%     col_4 = find(element.vertices(:,4)==no);
%     if vertex.flag(i)==101
%         inj = unique([col_1;col_2;col_3;col_4]);
%     else
%         prod = unique([col_1;col_2;col_3;col_4]);
%     end
% end
%wells = zeros(size(inj,1)+size(prod,1),6);
wells_dirch = [ones(num_dirichlet,1) find(ref_dirich_element) ...
                zeros(num_dirichlet,2) [400+ (1:num_dirichlet)]' ...
                ones(num_dirichlet,1) ];

wells_neuman = [ones(num_neuman,1)*2 find(ref_neuman_element) ...
                zeros(num_neuman,2) [400+ (1:num_neuman)]'...
                ones(num_neuman,1)*0 ];
wells = [wells_dirch; wells_neuman];
% for iw=1:size(inj,1)
%     wells(iw,1) = 1;
%     wells(iw,2) = inj(iw);
%     wells(iw,5) = 400 + iw;
%     wells(iw,6) = 1; % AJEITAR ISSO!!!
% end
% 
% for iw=1:size(prod,1)
%     wells(iw + size(inj,1),1) = 2;
%     wells(iw + size(inj,1),2) = prod(iw);
%     wells(iw + size(inj,1),5) = 400 + iw + size(inj,1);
%     wells(iw + size(inj,1),6) = 0; % AJEITAR ISSO!!!
% end
% 
% 1
end

