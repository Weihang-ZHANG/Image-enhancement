image_files = dir(fullfile('/home/ZWH1573/PycharmProjects/ResNet/GTSRB/Train/*', '*.png'));
input_images = cell(1, length(image_files));

for i = 1:length(image_files)
    input_images{i} = imread(fullfile(image_files(i).folder, image_files(i).name));
    img = imresize(input_images{i}, [32,32]);
    out = histeq(img);
    class = strsplit(image_files(i).folder, '/');
    imwrite(out, fullfile(['/home/ZWH1573/PycharmProjects/ResNet/GTSRB/histeq/', class{8}], image_files(i).name));
end