function [] = appleFunc()

%MATLAB code for finding ripness, size and defects of the apple

% Inputing the image
Im1 = imread('apple/ripe apple 1.jpg'); 
figure(1);
imshow(Im1);
title('Original image');

% coverting to the gray scale
grayIm1 = rgb2gray(Im1);
figure(2);
imshow(grayIm1);
title('Gray Scale Image');

% Histogram  
figure(3);
imhist(grayIm1);
xlabel('Intensity');
ylim([0 1000]);
ylabel('No. of pixels');
title('Histogram of The Input image');

%feature extraction
% dark red - red :[128,255]
% threshold for banana around 200
Threshold = 180;    %turn white all the pixels after 180
figure(4); 
binaryIm3 = grayIm1 > Threshold;
imshow(binaryIm3);
title('Binary Image');

% edge detection
bw = edge(binaryIm3,'canny');
figure(5);
imshow(bw);
title('Edge Detection');

% Size of the apple
[row, col, ~] = find(bw);   % Find indices of nonzero elements.
all_cords = [row, col];
max_chordLength  = max(pdist(all_cords)); % returns the Euclidean distance between pairs of observations in all_chords.
if(max_chordLength < 400)
    disp('Small sized apple');
else
    disp('Large sized apple');
end

%Finding the ripeness
Im2 = Im1;
idx = all(Im1>=160,3); % 1s and 0s -> 1: non-zero element & 0: zero element
Im1(repmat(idx,[1,1,3])) = 0; %B = repmat(A,[P1,P2,...,Pn]) tiles the array 
  %  A to produce an 3-dimensional array B composed of copies of A.
figure(6);
imshow(Im1);% Converting to new image with black background
title('Background Changed');

grayIm1 = rgb2gray(Im1); % New gray scale image
[M,N] = size(grayIm1);

figure(7);
imhist(grayIm1);
ylim([0 1000]);
title('Histrogram of new Grayscale Image');

alpha = 20; % Threshold for extracting the red components
count = 1;
count1 = 1;
% iterate through the grayscale image
for i = 1:M
    for j = 1:N
        if(grayIm1(i,j)>alpha && grayIm1(i,j)<alpha + 120)% 20 < grayIm1[i][j] <140 
            count = count + 1;  % red components
        elseif(grayIm1(i,j)>alpha+120)      % >140
            count1 = count1 + 1; %bright pixels ->non-red
        end
    end
end

figure(8);
imshow(Im2);    % Display Result
R = count/count1; % ratio = red components / non red components
if(R>10)
    title('Result - Rotten')
    disp('Rotten Apple');
else
    if (R>1)
        title('Result - Ripe');
        disp('Ripe Apple');
    else
        if(R<1)
            title('Result - Unripe');
            disp('Unripe Apple');
        end
    end
end

end