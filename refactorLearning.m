%Learning refactor rule (Learning Semantic informaiton)

function [refactor_rule] = refactorLearning(compactRepresentation, r)
%r number of action components


affinity = HSIC(compactRepresentation);

refactor_rule = spectralClustering(affinity, r);




