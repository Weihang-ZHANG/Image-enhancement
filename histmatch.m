image_files = dir(fullfile('/home/ZWH1573/PycharmProjects/ResNet/GTSRB/1of8/42', '*.png'));
input_images = cell(1, length(image_files));
ref1 = 0.1*randn(128,128)+0.25;
ref2 = 0.1*randn(128,128)+0.5;
ref3 = 0.1*randn(128,128)+0.75;
ref4 = 0.1*randn(128,128)+0.125;
ref5 = 0.1*randn(128,128)+0.375;
ref6 = 0.1*randn(128,128)+0.635;
ref7 = 0.1*randn(128,128)+0.875;

for i = 1:length(image_files)
    
    input_images{i} = im2double(imread(fullfile(image_files(i).folder, image_files(i).name)));
    
    J1 = imhistmatch(input_images{i}, ref1);
    J2 = imhistmatch(input_images{i}, ref2);
    J3 = imhistmatch(input_images{i}, ref3);
    J4 = imhistmatch(input_images{i}, ref4);
    J5 = imhistmatch(input_images{i}, ref5);
    J6 = imhistmatch(input_images{i}, ref6);
    J7 = imhistmatch(input_images{i}, ref7);
    temp = strsplit(image_files(i).name, '.');
    class=strsplit(image_files(i).folder, '/');
    imwrite(input_images{i}, fullfile(['/home/ZWH1573/PycharmProjects/ResNet/GTSRB/1of8hm/', class{8}], image_files(i).name));
    imwrite(J1, fullfile(['/home/ZWH1573/PycharmProjects/ResNet/GTSRB/1of8hm/', class{8}], [temp{1}, '_1', '.png']));
    imwrite(J2, fullfile(['/home/ZWH1573/PycharmProjects/ResNet/GTSRB/1of8hm/', class{8}], [temp{1}, '_2', '.png']));
    imwrite(J3, fullfile(['/home/ZWH1573/PycharmProjects/ResNet/GTSRB/1of8hm/', class{8}], [temp{1}, '_3', '.png']));
    imwrite(J4, fullfile(['/home/ZWH1573/PycharmProjects/ResNet/GTSRB/1of8hm/', class{8}], [temp{1}, '_4', '.png']));
    imwrite(J5, fullfile(['/home/ZWH1573/PycharmProjects/ResNet/GTSRB/1of8hm/', class{8}], [temp{1}, '_5', '.png']));
    imwrite(J6, fullfile(['/home/ZWH1573/PycharmProjects/ResNet/GTSRB/1of8hm/', class{8}], [temp{1}, '_6', '.png']));
    imwrite(J7, fullfile(['/home/ZWH1573/PycharmProjects/ResNet/GTSRB/1of8hm/', class{8}], [temp{1}, '_7', '.png']));
end