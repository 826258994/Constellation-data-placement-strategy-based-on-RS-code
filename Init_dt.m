function Download_track = Init_dt(SG)
%初始化结构体
pop.x = []; % 放置策略
pop.xe = [];% 计算节点位置
pop.fitness = [];% 适应度（总能耗）
pop.penaty = []; % 罚函数
Download_track = repmat(pop,1,1);

%找到空闲节点里在下载轨道上的下标
start = -1;
for i = 1 : SG.S
    if start == -1 && SG.idle_pos(i,1) == SG.d
        start = i;
    end
    if SG.idle_pos(i,1) == SG.d + 1
        last = i - 1;
        break;
    end
end

n = last - start + 1;%下载轨道的空闲节点数
d_x = (start:last);

% 1、下载轨道的空闲节点数大于校验块数量
if n >= SG.r
    % 在下载轨道随机放r个校验块
    index = randperm(n,SG.r);
    Download_track.x = d_x(index);

% 2、校验块多于下载轨道空闲节点数
else
    remain = SG.r - n; %剩余未放置的校验块
    if SG.S - last >= remain
        r_x = (last + 1:last + remain);
    else
        r_x = (start - remain:start + 1);
    end
    Download_track.x = [d_x,r_x];
end