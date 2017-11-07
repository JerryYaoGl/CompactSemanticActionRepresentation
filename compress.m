%compress representation according to the learned compree rule

function [compactRepresentation] = compress(initalRepresentation, compress_rule, k1);
%k1: the size of codebook after compression (the dimension of compact representation)

temp = initalRepresentation';

for i = 1:size(temp, 1)-k1

    merge_pair = compress_rule(1,:);
  
    merged_hist_bin = temp(merge_pair(1),:) + temp(merge_pair(2),:);
  
    temp(merge_pair,:) = [];
    compress_rule(1,:) = [];
  
    temp = [temp; merged_hist_bin];

end

compactRepresentation = temp'

