function activity_measure = weighted_sum_modified_laplacian( sband_mat )
    % ! to be modified:
    % activity measure used for high-frequency sub-band fusion:
    % weighted sum-modified laplacian (WSML) method
    % 
    % to accomplish eq.6, eq.7 and eq.8 of the paper:
    % CT and MR Image Fusion Scheme in Nonsubsampled Contourlet Transform Domain
    % for further high frequency sub-bands fusion of the image fusion program
    % 
    % Input:
    %   sub-band to compute the weighted sum-modified laplacian (WSML) activity level
    % 
    % 
    % Output:
    %   Activity measure matrix, value of the specific position p(m,n): 
    %   windowed mean centered at position p at original matrix
    %   
    % the weighted sum: is within a 3x3 window
    % 


    [p,q] = size(sband_mat);

    % Modified Laplacian computation of the input sub-band matrix:
    mod_lap = zeros(p,q);
    % MLf(x,y)= |2f(x,y)?f(x?1,y)?f(x+1,y)|+|2f(x,y)?f(x,y?1)?f(x,y+1)|
    % MLf(x,y)=              A1            +               A2
    % using periodical boundary condition:
    for m=1:p
        for n=1:q
            r_idx = m; c_idx = n;

            A1 = 0; A2 = 0;
            % whether row index at the boundary:
            if m >= 2 && m <= (p-1)
                A1 = abs( 2*sband_mat(m,n)-sband_mat(m-1,n)-sband_mat(m+1,n) );
            elseif (m-1) < 1
                A1 = abs( 2*sband_mat(m,n)-sband_mat(p-abs(m-1),n)-sband_mat(m+1,n) );
            elseif (m+1) > p
                A1 = abs( 2*sband_mat(m,n)-sband_mat(m-1,n)-sband_mat(m+1-p,n) );

            end


            % whether column index at the boundary:
            if n >= 2 && n <= (q-1)
                A2 = abs( 2*sband_mat(m,n)-sband_mat(m,n-1)-sband_mat(m,n+1) );
            elseif (n-1) < 1
                A2 = abs( 2*sband_mat(m,n)-sband_mat(m,q-abs(n-1))-sband_mat(m,n+1) );
            elseif (n+1) > q
                A2 = abs( 2*sband_mat(m,n)-sband_mat(m,n-1)-sband_mat(m,n+1-q) );

            end

            mod_lap(m,n) = A1+A2;

        end
    end


    % init output activity_measure:
    activity_measure = zeros(p,q);

    % weight matrix:
    w = [1/16 2/16 1/16; 2/16 4/16 2/16; 1/16 2/16 1/16];


    % weighted sum computation:
    for m=1:p
        for n=1:q

            % windowed mean value:
            for i=-1:1
                for j=-1:1

                    % Periodical boundary condition:
                    if (m+i)>=1 && (m+i)<=p && (n+j)>=1 && (n+j)<=q
                        activity_measure(m,n) = activity_measure(m+i,n+j) + mod_lap(m+i,n+j)*w(i+2, j+2);
                    elseif (m+i)<1 && (n+j)<1
                        activity_measure(m,n) = activity_measure(m,n) + mod_lap(p-abs((m+i)),q-abs((n+j)))*w(i+2, j+2);
                    elseif (m+i)<1 && (n+j)>=1 && (n+j)<=q
                        activity_measure(m,n) = activity_measure(m,n) + mod_lap(p-abs((m+i)),n+j)*w(i+2, j+2);
                    elseif (m+i)<1 && (n+j)>q
                        activity_measure(m,n) = activity_measure(m,n) + mod_lap(p-abs((m+i)),n+j-q)*w(i+2, j+2);
                    elseif (m+i)>=1 && (m+i)<=p && (n+j)>q
                        activity_measure(m,n) = activity_measure(m,n) + mod_lap(m+i,n+j-q)*w(i+2, j+2);
                    elseif (m+i)>p && (n+j)>q
                        activity_measure(m,n) = activity_measure(m,n) + mod_lap(m+i-p,n+j-q)*w(i+2, j+2);
                    elseif (m+i)>p && (n+j)>=1 && (n+j)<=q
                        activity_measure(m,n) = activity_measure(m,n) + mod_lap(m+i-p,n+j)*w(i+2, j+2);
                    elseif (m+i)>p && (n+j)<1
                        activity_measure(m,n) = activity_measure(m,n) + mod_lap(m+i-p,q-abs((n+j)))*w(i+2, j+2);
                    elseif (m+i)>=1 && (m+i)<=p && (n+j)<1
                        activity_measure(m,n) = activity_measure(m,n) + mod_lap(m+i,q-abs((n+j)))*w(i+2, j+2);


                    end

                end
            end

        end
    end

