function CC = correlation_coef_img_fn( img_a, img_b )
    % Correlation Coefficient computation between two input images
    % 
    % to accomplish eq.28 of the paper:
    % CT and MR Image Fusion Scheme in Nonsubsampled Contourlet Transform Domain
    % 
    % Input:
    %   img_a, img_b: two input images for CC computation
    % Output:
    %   CC: computed result correlation coefficient value
    % 
    %! NOTICE: input images should be the same size!
    % 
    % 


    [p, q] = size(img_a)
    img_a = double(img_a);
    img_b = double(img_b);

    % mean value for input images:
    mean_a = mean(img_a(:));
    mean_b = mean(img_b(:));
    % CC = A/B:
    A = sum(reshape((img_a-mean_a).*(img_b-mean_b),1,[]));
    B = ((sum(reshape((img_a-mean_a).^2,1,[]))) * (sum(reshape((img_b-mean_b).^2,1,[]))))^0.5;
    CC = A/B;


