function [sorted_elem,rr] = sort_elem_symrcm(elem)
ind = [1:size(elem,1)]';
auxmat = [ind elem(:,1); ind elem(:,2); ind elem(:,3); ind elem(:,4)];
auxmat = sparse(auxmat(:,1),auxmat(:,2), true);
trans_spy = auxmat*auxmat';
rr = symrcm(trans_spy);
sorted_elem = elem(rr,:); 
end