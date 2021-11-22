%%
% NSCT image fusion main program
clear all;
% perform NSCT for image
%%

% add nsct toolbox dir:
nsct_tbx_dir = 'G:\医学影像\Image_Fusion\ppr_code\2_nsct_Padma_2014_fsn\nsct';
addpath(nsct_tbx_dir);
% ! 1.load image:
img_name_a = "G:\医学影像\Image_Fusion\med_a.jpg";
img_name_b = "G:\医学影像\Image_Fusion\med_b.jpg";
fused_path = 'G:\医学影像\Image_Fusion\ppr_code\2_nsct_Padma_2014_fsn\results\';
I_a = imread(img_name_a);
I_b = imread(img_name_b);

% 使用double函数进行格式转换，则后面nsctrec之后，需要用uint8(fusion)进行转换；
I_a = double(I_a);
I_b = double(I_b);

% convert to gray scale image 
% I_a = rgb2gray(I_a); 
% I_b = rgb2gray(I_b); 

%%
% ! 2.decomposition for input image:

% pyramidal decomposition levels: 2, 
% with 8 and 4 directional sub-bands (high frequency sub-bands) in the first and second decomposition level respectively
% which will be in the reverse order for the vector:
nlevels = [2, 3];

pfilt = '9-7' ; % Pyramidal filter for initial decomposition
dfilt = 'pkva' ; % Directional decomposition filter

% 'pkva','9-7'

coef_a = nsctdec( I_a, nlevels, dfilt, pfilt );
coef_b = nsctdec( I_b, nlevels, dfilt, pfilt );

%%
% ! 3.perform coefficients fusion mthod to obtain final fused image

% low frequency sub-bands fusion

lo_a = coef_a{1};
lo_b = coef_b{1};

% fused low frequency sub-band:
coef_fusn{1} = low_freq_sband_fusn(lo_a, lo_b);

% high frequency sub-bands fusion 
for i=2:length(coef_a)
    for j=1:length(coef_a{i})

        coef_fusn{i}{j} = high_freq_sband_fusn(coef_a{i}{j}, coef_b{i}{j});

    end
end



%%
% ! 4.perform NSCT reconstruction, display and write fused image to local
% file
I_fusn = nsscrec(coef_fusn, dfilt, pfilt);
% I_fusn = uint8(I_fusn);
figure(1);
imshow(uint8(I_fusn));
title('NSCT Fused Image');
imwrite(uint8(I_fusn),strcat(fused_path,'nsct_fused_1-1.png'),'png');
save(strcat(fused_path,'nsct_fused_1-1.mat'), 'I_fusn');
