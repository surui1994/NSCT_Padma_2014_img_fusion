function fused_sband=low_freq_sband_fusn( sband1, sband2 )
    % low frequency sub-bands fusion for NSCT transformed images
    % 
    % to accomplish eq.4 and eq.5
    % of the paper:
    % CT and MR Image Fusion Scheme in Nonsubsampled Contourlet Transform Domain
    % 
    % input:
    %   sband1, sband2: low frequency sub-bands from images to be fused
    % output:
    %   fused_sband: the fused low frequency sub-band
    % 
    % 
    % consistency verification, and decision map 
    % 
    % 
    % 
    % 
    % 
    % 


    % 1. compute activity measure of input sub-bands
    act_sband1 = entropy_squared_coef(sband1);
    act_sband2 = entropy_squared_coef(sband2);

    % decision map for sband1:
    % for max choosing method:
    w_sband1 = (act_sband1 >= act_sband2);
    w_sband1 = double(w_sband1);
    
    % perform consistency verification to decision map:
    [r,c] = size(act_sband1); 

    for i=1:r
        for j=1:c
            s=0; t=0;

            s = s+w_sband1(i,j); t=t+1;
            if(i>1)
               s=s+w_sband1(i-1,j); t=t+1;
            end
            if(j>1)
               s=s+w_sband1(i,j-1); t=t+1;
            end
            if(i<r)
               s=s+w_sband1(i+1,j); t=t+1;
            end
            if(j<c)
               s=s+w_sband1(i,j+1); t=t+1;
            end
            if(i>1&&j>1)
               s=s+w_sband1(i-1,j-1); t=t+1;
            end
            if(i>1&&j<c)
               s=s+w_sband1(i-1,j+1); t=t+1;
            end
            if(i<r&&j>1)
               s=s+w_sband1(i+1,j-1); t=t+1;
            end
            if(i<r&&j<c)
               s=s+w_sband1(i+1,j+1); t=t+1;
            end

            if(s > t/2)
                w_sband1(i,j)=1;
            elseif(s <= t/2)
                w_sband1(i,j)=0;  
            end
        end
    end
    
    % the final decision map are w_sband1 and w_sband2:
    w_sband2 = 1-w_sband1;

    % eq.5:
    fused_sband = w_sband1.*sband1 + w_sband2.*sband2;
