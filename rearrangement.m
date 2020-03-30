% Rearrangement Test set by average luminance of images (low, middle, high) 

image_files = dir(fullfile('/home/ZWH1573/PycharmProjects/ResNet/GTSRB/Test/*/', '*.png'));
input_images = cell(1, length(image_files));
for i = 1:length(image_files)
    input_images{i} = imread(fullfile(image_files(i).folder, image_files(i).name));
    img = imresize(input_images{i}, [32,32]);
    avg = mean2(img);
    class=strsplit(image_files(i).folder, '/');
    if avg < 85
        imwrite(img, fullfile(['/home/ZWH1573/PycharmProjects/ResNet/GTSRB/recombination/low/', class{8}], image_files(i).name));
    else
        if avg > 170
            imwrite(img, fullfile(['/home/ZWH1573/PycharmProjects/ResNet/GTSRB/recombination/high/', class{8}], image_files(i).name));
        else
            imwrite(img, fullfile(['/home/ZWH1573/PycharmProjects/ResNet/GTSRB/recombination/middle/', class{8}], image_files(i).name));
        end
    end
end