% Shi Malik  SpectralClustering
function [C] = spectralClustering(W, r)

degs = sum(W, 2);
D= sparse(1:size(W, 1), 1:size(W, 2), degs);

L = D - W;
degs(degs == 0) = eps;
D = spdiags(1./degs, 0, size(D, 1), size(D, 2));
L = D * L;
diff = eps;
[U, ~] = eigs(L, r, diff);

C = kmeans(U, r, 'start', 'cluster', ...
                 'EmptyAction', 'singleton');
