%Learning compress rule (Learning class distribution informaiton)

function [compress_rule] = compressLearning(initalRepresentation, label, k1);
%label: class label
%k1: the size of codebook after compression (the dimension of compact representation)


temp= initalRepresentation';

k = size(temp,1); % codebook size
m = length(unique(label)); % number of class label
classLabel = unique(label);

rule = [];


% initialize class distribution information: p_c_v  p_v
p_c_v = zeros (k, m);
p_c_v_sum = zeros (k, 1);
for labelID=1:m 
    idx = find(label==classLabel(labelID));
    for cwID=1:k 
        p_c_v(cwID, labelID) = sum(temp(cwID, idx));
    end
end

p_c_v = p_c_v./repmat(sum(p_c_v, 2), 1, size(p_c_v, 2))+eps;
p_v = sum(temp, 2)/ sum(sum(temp, 2)); 

for d=1:k 
    p_c_v_sum(d) = p_v(d)*sum(p_c_v(d, :).*log2(p_c_v(d, :)));
end


for iter=1:size(p_c_v, 1)-k1
    minMILost = inf;
    for va=1:size(p_c_v, 1)-1
        
        for vb=va+1:size(p_c_v, 1)
            
            p_v_tmp = p_v(va)+p_v(vb);
            p_c_v_tmp = (p_v(va)/p_v_tmp)*p_c_v(va,:) + (p_v(vb)/p_v_tmp)*p_c_v(vb,:);
            					
            temp1 = p_v(va)*sum(p_c_v(va,:).*log2(p_c_v_tmp));
            temp2 = p_v(vb)*sum(p_c_v(vb,:).*log2(p_c_v_tmp));
            
            MILost=p_c_v_sum(va)+p_c_v_sum(vb)-temp1-temp2;
            
            if MILost < minMILost
                minMILost = MILost;
                va1 = va;
                vb1 = vb;
            end
            
        end
    end
    
	fprintf(1,'(---- %d --%d-- %d ----%d\n',iter, va1, vb1, size(p_c_v, 1));
   
	
    %merge two codebook
    p_vs = p_v(va1)+p_v(vb1); 
    p_c_vs = (p_v(va1)/p_vs)*p_c_v(va1,:) + (p_v(vb1)/p_vs)*p_c_v(vb1,:);
    p_c_v_tmp_sum = p_vs*sum(p_c_vs.*log2(p_c_vs));
  
    % update class distribution information: p_c_v  p_v

    %remove va1 vb1
    p_v([va1 vb1]) = [];
    p_c_v_sum([va1 vb1]) = [];
    p_c_v([va1 vb1],:) = [];
    
    %add vs
    p_v = [p_v; p_vs];
    p_c_v_sum = [p_c_v_sum; p_c_v_tmp_sum];
    p_c_v = [p_c_v; p_c_vs];

    rule = [rule;[va1 vb1]];
	
end
   compress_rule = rule;

