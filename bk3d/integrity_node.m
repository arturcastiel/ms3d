function [ref] = integrity_node(loc_elem)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
global face element

loc = unique(element.vertices(loc_elem,:));
loc_bedge = unique(element.vertices(loc_elem,:));
loc = unique([loc ; loc_bedge]);
ref = ismember(element.vertices,loc);
ref = sum(ref,2) >=3;

end