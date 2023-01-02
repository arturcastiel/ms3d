function [multiplication] = multiply_vec_tensor_vec(vec1,perm,vec2)
v1 = vec1(:,1);
v2 = vec1(:,2);
v3 = vec1(:,3);
p1 = vec2(:,1);
p2 = vec2(:,2);
p3 = vec2(:,3);
a = perm(:,1);
b = perm(:,2);
c = perm(:,3);
d = perm(:,4);
e = perm(:,5);
f = perm(:,6);
g = perm(:,7);
h = perm(:,8);
i = perm(:,9);
multiplication = ...
    p1.*(a.*v1 + d.*v2 + g.*v3) + p2.*(b.*v1 + e.*v2 + h.*v3) + ...
    p3.*(c.*v1 + f.*v2 + i.*v3);
end