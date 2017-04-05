dirList = subdir('E:\Landsat8\*.xml');
for dirId = 1:size(dirList)
    dirList(dirId).name
    [pathstr,name,ext] = fileparts(dirList(dirId).name);
    cd( pathstr )
    for i = 1:7
        [Img(:,:,i), R(i)] = geotiffread( [name '_sr_band' num2str(i) '.tif'] );
        tiffinfo(i) = geotiffinfo([name '_sr_band' num2str(1) '.tif']);
    end
    
    
    copyfile([name '_cfmask.tif'],[ '..\' name '_cfmask.tif'])
    geotiffwrite(['..\' name '.tif'], Img, R(1), 'GeoKeyDirectoryTag', tiffinfo(1).GeoTIFFTags.GeoKeyDirectoryTag);
    clear Img;
end