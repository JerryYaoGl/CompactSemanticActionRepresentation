%calculate affinity matrix of Hilbert-Schmidt Independence Criterion (HSIC) 

function affinity  = HSIC(compactRepresentation)

k1 = size(compactRepresentation,2); %number of bins (size of codebook)
N = size(compactRepresentation,1);  %number of training samples

H = eye(N)-1/N*ones(N,N);

for vi = 1:k1
    L = RBF_innerProduct(compactRepresentation(:,vi));
    affinity(vi,vi) = trace(H*L*H*L) ;
    disp(vi);
    for vj = vi+1:k1
        K = RBF_innerProduct(compactRepresentation(:,vj));
        affinity(vi,vj) = trace(H*L*H*K) ;
        affinity(vj,vi) = affinity(vi,vj);
    end
end
