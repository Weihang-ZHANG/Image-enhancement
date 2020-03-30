% read multi-exposure images
image_files = dir(fullfile('/home/ZWH1573/PycharmProjects/ResNet/GTSRB/1of8aug/42', '*.png'));
input_images = cell(1, length(image_files));
for i = 1:length(image_files)
    tmp_image = im2double(imread(fullfile(image_files(i).folder, image_files(i).name)));
    input_images{i} = tmp_image.^2.2; % inverse gamma correction

    % local contrast enhancement
    enhanced_images = local_contrast_enhancement({input_images{i}});

    % scene segmentation
    extractor = ROIExtractor('approach1', 7);
    regions = extractor.extract(enhanced_images);

    % luminance scaling
    adjuster = BrightnessAdjuster(0.18);
    adjusted_images = adjuster.adjust(enhanced_images, regions);

    % tone mapping
    mapped_images = tone_map(adjusted_images);

    output_images = cell(1, 7);
    for j = 1:7
        tmp_image = mapped_images{j};
        tmp_image(tmp_image < 0) = 0;
        tmp_image(tmp_image > 1) = 1;
        output_images{j} = tmp_image.^(1/2.2); % gamma correction
        temp = strsplit(image_files(i).name, '.');
        imwrite(output_images{j}, fullfile(image_files(i).folder, [temp{1}, '_',num2str(j), '.png']));
    end
end
