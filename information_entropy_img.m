function ie=information_entropy_img(img_mat)
    % compute the information entropy of an image
    % 
    % to accomplish eq.13
    % of the paper:
    % CT and MR Image Fusion Scheme in Nonsubsampled Contourlet Transform Domain
    % 
    % Input:
    %   img_mat: image matrix
    % Output:
    %   information entropy value
    % 

    img_mat = uint8(img_mat);
    [p,q] = size(img_mat);

    % max gray value of the image:
    L=256;
    ie = 0;

    for i=0:L-1
        % ratio of the num of pixels with gray value equal to i 
        % over total num of pixels of the input image:
        ratio = (sum( reshape( img_mat==L,1,[] ) ))/(p*q);
        ie = ie + ratio*log2(ratio);


    end

    % output:
    ie = ie*(-1);

