function [outimg1,outimg2,flag,num] = face_detection_func(img)
    %调用人脸检测模型
    %创建vision.CascadeObjectDetector对象并设置其属性
    FDetect = vision.CascadeObjectDetector;
    %获取图像存储原图像
    I_orig=img;
    %检测人脸，使用创建的FDetect对象作为参数检测人脸
    face_dtect = step(FDetect,I_orig);
    %图片尺寸，K是第三维
    [Height,Width,K]=size(I_orig);
    %检测人数，即face_dtect的行数
    Num_face=size(face_dtect,1)
    %规整化尺寸
    normal_size=mod(300,227);
    %存储人脸，调用zeros函数创建一个能存放人脸数量的矩阵
    I_mask=zeros(normal_size,normal_size*Num_face,K);
    outimg1=(I_orig);
    % Num_face是检测到的人脸数
    for i = 1:Num_face
        %行序号
        row_set=face_dtect(i,2)+1:min(Height,face_dtect(i,2)+face_dtect(i,4));
        %列序号
        cul_set=face_dtect(i,1)+1:min(Width,face_dtect(i,1)+face_dtect(i,3));
        %截取
        im=I_orig(row_set,cul_set,:);
        %尺寸调整
        im2=imresize(im,[normal_size,normal_size]);
        %存储
        I_mask(:,(i-1)*normal_size+1:i*normal_size,:)=im2;
    end
    %识别图片内容 
    if Num_face>0
        %使用uint8函数将I_mask转换为8位无符号整数，存储图像（8位图像）
        outimg2=uint8(I_mask);
        flag=1;
    else
        outimg2=I_orig;%原图像
        flag=0;
    end
    num=Num_face %人数
end
