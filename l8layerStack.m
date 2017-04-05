dirList = subdir('D:\LC81810332016211LGN00-kurak-menemen\*.txt');
for dirId = 1:size(dirList)
    dirList(dirId).name
    [pathstr,name,ext] = fileparts(dirList(dirId).name);
    if strcmp(name(end-2:end), 'MTL')
        cd( pathstr )
        name = name(1:end-4);
        for i = 1:7
            [Img(:,:,i), R(i)] = geotiffread( [name '_B' num2str(i) '.tif'] );
            tiffinfo(i) = geotiffinfo([name '_B' num2str(1) '.tif']);
        end
        for i = 10:11
            [ImgT(:,:,i), RT(i)] = geotiffread( [name '_B' num2str(i) '.tif'] );
            tiffinfoT(i) = geotiffinfo([name '_B' num2str(1) '.tif']);
        end
        
        copyfile([name '_MTL.txt'],[ '..\' name '_MTL.txt'])
        geotiffwrite(['..\' name '_OLI' '.tif'], Img, R(1), 'GeoKeyDirectoryTag', tiffinfo(1).GeoTIFFTags.GeoKeyDirectoryTag);
        geotiffwrite(['..\' name '_TIRS' '.tif'], ImgT, RT(1), 'GeoKeyDirectoryTag', tiffinfoT(1).GeoTIFFTags.GeoKeyDirectoryTag);
        
        clear Img; clear ImgT;
        clear tiffinfo; clear tiffinfoT; clear R; clear RT;
    end
end