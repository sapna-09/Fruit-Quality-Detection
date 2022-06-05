%MATLAB code for finding ripness, size and defects of the banana
function [] = bananaFunc()    

% Inputing the image
Im1 = imread('banana/raw banana.jpg'); 
figure(1);
imshow(Im1);
title('Original image');

% coverting to the gray scale
grayIm1 = rgb2gray(Im1);
figure(2);
imshow(grayIm1);
title('Gray Scale Image');

%Histogram  
figure(3);
imhist(grayIm1);
xlabel('Intensity');
ylim([0 1000]);
ylabel('No. of pixels');
title('Histogram of The Input image');

%feature extraction
%threshold for banana around 200
Threshold = 50;    
figure(4); 
% Threshold is between 50 and 200
binaryIm1 = (grayIm1 < Threshold); 
binaryIm2 = (grayIm1 > 200);
binaryIm3 = imadd(binaryIm1, binaryIm2);
imshow(binaryIm3);
title('Binary Image');

%edge detection
bw = edge(binaryIm3,'canny');
figure(5);
imshow(bw);
title('Edge Detection');

% Size of banana using Perimeter
S=regionprops(  bwareafilt(bw,1,'largest') ,'Perimeter'); % extracting 1 largest object from binary image by size
length=S.Perimeter/2;
if(length > 200)
    disp('Large sized banana');
else
    disp('Small sized banana');
end

% Finding the ripeness
Im2 = Im1;
idx = all(Im1>=160,3); % 1s and 0s -> 1: non-zero element & 0: zero element
Im1(repmat(idx,[1,1,3])) = 0; %B = repmat(A,[P1,P2,...,Pn]) tiles the array 
  %  A to produce an 3-dimensional array B composed of copies of A.
figure(6);
imshow(Im1);% Converting to new image with black background
title('Background Changed');

grayIm1 = rgb2gray(Im1); % New gray scale image
[M,N] = size(grayIm1);

%display histogram of new gray scale image
figure(7);
imhist(grayIm1);
ylim([0 1000]);
title('Histrogram of new Grayscale Image');

%Display new gray scale image
% figure(11);
% imshow(grayIm1);

alpha = 60; % Threshold for extracting the yellow components
count = 1;
count1 = 1;
% iterate through the grayscale image
for i = 1:M
    for j = 1:N
        if(grayIm1(i,j)>alpha && grayIm1(i,j)<alpha + 120)% 60 < grayIm1[i][j] < 180 
            count = count + 1;  % yellow components
        elseif(grayIm1(i,j)>alpha+120)      % > 180
            count1 = count1 + 1; %bright pixels ->non-yellow
        end
    end
end

figure(8);
imshow(Im2);    % Display Result
R = count/count1; % ratio = yellow components / non-yellow components
if(R>5)
    title('Result - Rotten');
    disp('Rotten Banana');
    else if (R>1)
        title('Result - Unripe');
        disp('Unripe Banana');
    else if(R<1)
            title('Result - Ripe');
            disp('Ripe Banana');
        end
    end
end

end
