function sf = spatial_frequency_img_fn( mat )
    % spatial frequency value computation of an image
    % 
    % 
    % to accomplish eq.17, eq.18 and eq.19 of the paper:
    % CT and MR Image Fusion Scheme in Nonsubsampled Contourlet Transform Domain
    % 
    % Input:
    %   mat: image matrix to compute spatial frequency
    % 
    % Output:
    %   sf: spatial frequency value of the input image matrix
    % 
    % 
    % 
    [M, N] = size(mat);

    %* computation of row frequency, RF:
    count = 1;
    for i=1:M
        for j=2:N
            row_freq(count) = (mat(i, j) - mat(i, j-1))^2;
            count = count+1;
        end
    end
    
    row_freq = sqrt( sum(row_freq(:))/(M*N) );


    %* computation of column frequency, CF:
    count = 1;
    for j=1:N
        for i=2:M
            col_freq(count) = (mat(i, j) - mat(i-1, j))^2;
            count = count+1;
        end
    end
    
    col_freq = sqrt( sum(col_freq(:))/(M*N) );

    sf = sqrt( row_freq^2 + col_freq^2 );
