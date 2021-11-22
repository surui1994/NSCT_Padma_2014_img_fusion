function MI = mutual_info_img_fuse_fn( img_fused, img_a, img_b )
    % image fusion performance measure Mutual Information (MI)
    % 
    % to accomplish eq.25, eq.26 and eq.27 of the paper:
    % CT and MR Image Fusion Scheme in Nonsubsampled Contourlet Transform Domain
    % 
    % Input:
    %   img_fused: fused image;
    %   img_a, img_b: source images for image fusion
    % Output:
    %   MI: mutual information (MI) for image fusion performance measure
    % 

    MI = MI_GG( img_fused, img_a ) + MI_GG( img_fused, img_b );



