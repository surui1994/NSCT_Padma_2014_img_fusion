function activity_measure = entropy_squared_coef( sband_mat )
    % activity measure used for low-frequency sub-band fusion:
    % entropy of square of the coefficients within a 3¡Á3 window
    % 
    % to accomplish eq.2 and eq.3 of the paper:
    % CT and MR Image Fusion Scheme in Nonsubsampled Contourlet Transform Domain
    % for further low frequency sub-bands fusion of the image fusion program
    % 
    % Input:
    %   sub-band to compute the entropy of square of the coefficients within a 3x3 window
    % 
    % Output:
    %   Activity measure matrix, value of the specific position p(m,n): 
    %   windowed mean centered at position p at original matrix
    % 


    % element-wise squared of sub-band matrix
    squared_mat = sband_mat.^2;

    [p,q] = size(sband_mat);
    % init output activity_measure:
    activity_measure = zeros(p,q);


    for m=1:p
        for n=1:q

            % windowed mean value:
            for i=-1:1
                for j=-1:1

                    % Periodical boundary condition:
                    if (m+i)>=1 && (m+i)<=p && (n+j)>=1 && (n+j)<=q
                        activity_measure(m,n) = activity_measure(m+i,n+j) + squared_mat(m+i,n+j)*log(squared_mat(m+i,n+j));
                    elseif (m+i)<1 && (n+j)<1
                        activity_measure(m,n) = activity_measure(m,n) + squared_mat(p-abs((m+i)),q-abs((n+j)))*log(squared_mat(p-abs((m+i)),q-abs((n+j))));
                    elseif (m+i)<1 && (n+j)>=1 && (n+j)<=q
                        activity_measure(m,n) = activity_measure(m,n) + squared_mat(p-abs((m+i)),n+j)*log(squared_mat(p-abs((m+i)),n+j));
                    elseif (m+i)<1 && (n+j)>q
                        activity_measure(m,n) = activity_measure(m,n) + squared_mat(p-abs((m+i)),n+j-q)*log(squared_mat(p-abs((m+i)),n+j-q));
                    elseif (m+i)>=1 && (m+i)<=p && (n+j)>q
                        activity_measure(m,n) = activity_measure(m,n) + squared_mat(m+i,n+j-q)*log(squared_mat(m+i,n+j-q));
                    elseif (m+i)>p && (n+j)>q
                        activity_measure(m,n) = activity_measure(m,n) + squared_mat(m+i-p,n+j-q)*log(squared_mat(m+i-p,n+j-q));
                    elseif (m+i)>p && (n+j)>=1 && (n+j)<=q
                        activity_measure(m,n) = activity_measure(m,n) + squared_mat(m+i-p,n+j)*log(squared_mat(m+i-p,n+j));
                    elseif (m+i)>p && (n+j)<1
                        activity_measure(m,n) = activity_measure(m,n) + squared_mat(m+i-p,q-abs((n+j)))*log(squared_mat(m+i-p,q-abs((n+j))));
                    elseif (m+i)>=1 && (m+i)<=p && (n+j)<1
                        activity_measure(m,n) = activity_measure(m,n) + squared_mat(m+i,q-abs((n+j)))*log(squared_mat(m+i,q-abs((n+j))));


                    end

                end
            end

        end
    end

    activity_measure = activity_measure./9;
