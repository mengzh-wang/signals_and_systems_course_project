clc,clear,close all
Img1 = imread('.\aiyinsitan.jpg'); 			% 读取jpg图像文件
Img2= imread('.\menglu.jpg'); 				% 读取jpg图像文件
Image1 = imresize(Img1, [180*2, 132*2], 'bilinear'); % 截取相同图像大小
Image2 = imresize(Img2, [180*2, 132*2], 'bilinear'); % 截取相同图像大小
Image1 = rgb2gray(Image1);  					%转换为灰度 
Image2 = rgb2gray(Image2); 					%转换为灰度 


%=====================调参部分======================
%{
tiledlayout(3,5,'TileSpacing','tight',"Padding","tight");
for i=1:3
    for j=1:5
        
        sig1=6+2*i;sig2=6+2*j;
        mix=blend(sig1,sig2,Image1,Image2);
        nexttile
        imshow(mix);title([num2str(sig1),',',num2str(sig2)]);
    end
end
%}

%=============调参时请将以下代码改为注释==============

mix=blend(15,10,Image1,Image2);
figure("Name","融合后图像")
imshow(mix)
%imwrite(mix,"混合后图像.png")
%}