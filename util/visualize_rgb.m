function r=visualize_rgb(X)
n = size(X,2) / 3;

a(:,:,1) = visualize(X(:,1:n)');
a(:,:,2) = visualize(X(:,n+1:2*n)');
a(:,:,3) = visualize(X(:,2*n+1:end)');
for i = 1:3
a(:,:,i) = (a(:,:,i) - min(min(a(:,:,i)))) ./ (max(max(a(:,:,i)))-min(min(a(:,:,i))));
end
imshow(a);