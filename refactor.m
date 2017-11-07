%refactor representation according to the learned refactor rule

function compactSemanticRepresentation = refactor(compactRepresentation, refactor_rule)

r = size( unique(refactor_rule),1);   %number of action components

projmat = cell(r,1);
manifolds = cell(r,1);
for i = 1:r
    projmat{i} = find(refactor_rule==i);
    thisdata = compactRepresentation(:,projmat{i});
    thisdata = bsxfun(@rdivide, thisdata, sum(thisdata, 2)+eps);
    manifolds{i}=thisdata;
end
compactSemanticRepresentation = horzcat(manifolds{:});
compactSemanticRepresentation = bsxfun(@rdivide, compactSemanticRepresentation, sum(compactSemanticRepresentation, 2));

