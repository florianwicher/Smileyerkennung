function img = scaleDown(img, m)

minSize = min(size(I,1), size(I,2));

if minSize > m
   s = m / minSize;
   T = [s 0 0; 0 s 0; 0 0 1];
   img = imgTransform(img, T);
end