% read multi-exposure images
image_files = dir(fullfile('/home/ZWH1573/PycharmProjects/ResNet/GTSRB/eaTrain/*', '*.png'));
input_images = cell(1, length(image_files));
for i = 1:length(image_files)
    tmp_image = im2double(imread(fullfile(image_files(i).folder, image_files(i).name)));
    input_images{i} = tmp_image.^2.2; % inverse gamma correction

    % local contrast enhancement
    enhanced_images = local_contrast_enhancement(input_images(i));

    % scene segmentation
    extractor = ROIExtractor('approach1', 5);
    regions = extractor.extract(enhanced_images);

    % luminance scaling
    adjuster = BrightnessAdjuster(0.18);
    adjusted_images = adjuster.adjust(enhanced_images, regions);

    % tone mapping
    mapped_images = tone_map(adjusted_images);

    output_images = cell(1, length(mapped_images));
    for j = 1:length(mapped_images)
        tmp_image = mapped_images{j};
        tmp_image(tmp_image < 0) = 0;
        tmp_image(tmp_image > 1) = 1;
        output_images{j} = tmp_image.^(1/2.2); % gamma correction
    end

    % these output images can be fused by any fusion methods.
    % here, simple average is used as an example.
    fused_image = zeros(size(output_images{1}));
    for k = 1:length(mapped_images)
        fused_image = fused_image + output_images{k};
    end
    fused_image = fused_image / length(mapped_images);
    imwrite(fused_image, fullfile(image_files(i).folder, image_files(i).name))
end

% if you use MATLAB R2018b or later,
% blendexposure() function can fuse adjusted_images.