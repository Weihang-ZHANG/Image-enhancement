% Culculate number of images in different luminance range of trainset

image_files = dir(fullfile('/home/ZWH1573/PycharmProjects/ResNet/GTSRB/1of4aug/*/', '*.png'));
input_images = cell(1, length(image_files));
low_n = 0;
middle_n = 0;
high_n = 0;
for i = 1:length(image_files)
    input_images{i} = imread(fullfile(image_files(i).folder, image_files(i).name));
    img = imresize(input_images{i}, [32,32]);
    avg = mean2(img);
    if avg < 85
        low_n = low_n + 1;
    else
        if avg > 170
            high_n = high_n + 1;
        else
            middle_n = middle_n + 1;
        end
    end
end

        