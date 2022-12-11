function [area] = calc_area_triang(p1,p2,p3)
vec1 = p2-p1;
vec2 = p3-p1;
area = vecnorm(cross(vec1,vec2,2),2,2)*0.5;
end