function ce=cross_entropy_img( img_a, img_b )
    % compute the cross entropy of between two images
    % 
    % to accomplish eq.15 and eq.16
    % of the paper:
    % CT and MR Image Fusion Scheme in Nonsubsampled Contourlet Transform Domain
    % 
    % Input:
    %   img_a, img_b: image A and image B
    % Output:
    %   cross entropy value between image A and B
    % 

    img_a = uint8(img_a);
    img_b = uint8(img_b);
    [p,q] = size(img_a);

    % max gray value of the image:
    L=256;
    ce = 0;

    for i=0:L-1
        % ratio of the num of pixels with gray value equal to i 
        % over total num of pixels of the input image:
        ratio_a = (sum( reshape( img_a==L,1,[] ) ))/(p*q);
        ratio_b = (sum( reshape( img_b==L,1,[] ) ))/(p*q);

        ce = ce+ ratio_a*log2(abs( ratio_a/ratio_b ));

    end






