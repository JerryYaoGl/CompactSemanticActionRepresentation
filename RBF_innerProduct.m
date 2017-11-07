function [K] = RBF_innerProduct(xv)

N=size(xv,1);
G = sum((xv.*xv),2);
Q = repmat(G,1,N);
R = repmat(G',N,1);
K = Q + R - 2*(xv*xv');
dists = K-tril(K);
dists = reshape(dists,N^2,1);
deg2 = median(dists(dists>0));

K = exp(-K/deg2);
