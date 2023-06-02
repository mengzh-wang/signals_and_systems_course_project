function [mix]=blend(sigma_lp,sigma_hp,Image1,Image2)
    %提取频谱并平移
    s1=fftshift(fft2(Image1));
    s2=fftshift(fft2(Image2));
    figure("Name","高斯滤波器的频响特性");
    %用于高通的高斯函数
    gauss_hp=gaussian(sigma_hp,1);
    igauss=1-gauss_hp;

    %用于低通的高斯函数
    gauss=gaussian(sigma_lp,0);


    %滤波
    s1f=s1.*igauss;
    Image1_filter=uint8(real(ifft2(ifftshift(s1f))));
    s2f=s2.*gauss;
    Image2_filter=uint8(real(ifft2(ifftshift(s2f))));

    %五官对齐
    J=imcrop(Image1_filter,[13 1 248 359]);
    J=imresize(J,[350, 132*2], 'bilinear');
    J=[J;zeros(10,264)];
    K=[zeros(341,8),imcrop(Image2_filter,[1 20 260 340]),zeros(341,8)];
    K=imresize(K,[180*2, 132*2], 'bilinear');
    K=imtranslate(K,[-8, 12],'FillValues',0);
    K=imrotate(K,2.5,'crop');
    %图像混合
    mix=1.8.*imfuse(J,K,"blend","Scaling","joint");

    
    %=============调参时请将以下代码改为注释==============
    
    %滤波器频率响应
    figure("Name","高斯滤波器的频谱图")
    subplot(1,2,1);imshow(log(255.*igauss));title("高通");
    subplot(1,2,2);imshow(log(255.*gauss));title("低通");
    imwrite(igauss,"高通频响.png")
    imwrite(gauss,"低通频响.png")
    imwrite(log(255.*igauss),"高通频响取log.png")
    imwrite(log(255.*gauss),"低通频响取log.png")
   
    %原始图像和频谱 
    figure("Name","变换过程中的图像和频谱图")
    subplot(2,4,1);imshow(Image1);title("原图像（爱因斯坦）");
    subplot(2,4,5);imshow(log(abs(s1)),[0,16]);title("原频谱图（爱因斯坦）");
    subplot(2,4,3);imshow(Image2);title("原图像（梦露）");
    subplot(2,4,7);imshow(log(abs(s2)),[0,16]);title("原频谱图（梦露）");
    %imwrite(Image1,"原图像（爱因斯坦）.png")
    %imwrite(log(abs(s1)),"原频谱图（爱因斯坦）.png")
    %imwrite(Image2,"原图像（梦露）.png")
    %imwrite(log(abs(s2)),"原频谱图（梦露）.png")

    %滤波后图像和频谱
    subplot(2,4,2);imshow(Image1_filter);title("滤波后图像（爱因斯坦）");
    subplot(2,4,6);imshow(log(abs(s1f)),[0,16]);title("滤波后频谱图（爱因斯坦）");
    subplot(2,4,4);imshow(Image2_filter);title("滤波后图像（梦露）");
    subplot(2,4,8);imshow(log(abs(s2f)),[0,16]);title("滤波后频谱图（梦露）");
    %imwrite(Image1_filter,"滤波后图像（爱因斯坦）.png")
    %imwrite(log(abs(s1f)),"滤波后频谱图（爱因斯坦）.png")
    %imwrite(Image2_filter,"滤波后图像（梦露）.png")
    %imwrite(log(abs(s2f)),"滤波后频谱图（梦露）.png")
    %}
end

