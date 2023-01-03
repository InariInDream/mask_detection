clc,clear,close all  % 清理命令区、清理工作区、关闭显示图形
warning off       % 消除警告
feature jit off      % 关闭即时编译，加快运行速度
tic         % 开始计时
[filename ,pathname]=...
    uigetfile({'*.*';'*.jpg';'*.png';},'选择图片'); %选择图片路径
% 合成路径+文件名
str=[pathname filename]; 
%如果取消选择，启动视频
if str
     % 读图
    img = imread(str);       
    image_process(img,'picture');
else
    %读取图片
    cam=webcam(1);
    img=snapshot(cam);
    %显示图片
    preview(cam)
    % 使用snapshot函数获取图像
    img = snapshot(cam);    
    % 显示图像
    figure,image(img);
    %设置帧数
    num_frame=1;
    % 获取num_frame个帧
    for idx = 1:num_frame
        %循环获取num_frame个帧
        figure;
        %获取每一帧图片
        img = snapshot(cam);
        image_process(img,"video");
        %每隔3秒处理一次
        pause(3)
    end
    clear cam
end
