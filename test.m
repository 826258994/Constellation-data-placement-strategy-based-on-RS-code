clc;
clear;
%% 定义卫星星座参数
SG = creatSG();
%% 测试
Random = Init(1,SG.S,SG.r); %初始化随机放置
Random = search_cpNode(SG,Random);%找每个个体对应的计算节点
Random = penalty(SG,Random); %计算初始罚函数

%不断生成随机放置策略直到满足时延约束条件，即罚函数为0
while (Random.penalty ~= 0)
    Random = Init(1,SG.S,SG.r); 
    Random = search_cpNode(SG,Random);
    Random = penalty(SG,Random);
end

Random = Total_eng(SG,Random); %计算初始适应度


Download_track = Init_dt(SG); %初始化放置于下载轨道的放置策略
Download_track = search_cpNode(SG,Download_track);%找每个个体对应的计算节点
Download_track = Total_eng(SG,Download_track); %计算初始适应度
Download_track = penalty(SG,Download_track); %计算初始罚函数

disp(['随机放置策略的适应度为：',num2str(Random.fitness),newline,...
    '放置策略为：',num2str(Random.x),newline,...
    '聚集下载轨道放置的适应度为：',num2str(Download_track.fitness),newline,...
    '放置策略为：',num2str(Download_track.x)]);