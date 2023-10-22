% 输入：空闲节点和数据节点的坐标、校验块放置策略
% 输出：计算节点的坐标
function up_Population = search_cpNode(SG,Population)
% 最佳计算节点不一定在校验节点中，应该遍历所有空闲节点找最好的
% index = find(x == 1); % 计算点在校验块放置节点里找，即找x=1的下标
for i = 1 : size(Population,2)
    eng_min = 10e6; % 最小能耗初始化成一个很大的数
    parity = SG.idle_pos(Population(i).x,:); %校验块坐标
    for j = 1 : size(SG.idle_pos,1)
        x_c = SG.idle_pos(j,1); %备选计算节点的坐标
        y_c = SG.idle_pos(j,2);
        diff = [abs([x_c,y_c] - SG.data_pos);abs([x_c,y_c] - parity)];
        % 以行划分轨道，每一行是一条轨道
        eng_deploy = sum(diff(:,1)*SG.Pt_inter/SG.C_inter + diff(:,2)*SG.Pt_intra/SG.C_intra);
        if eng_deploy < eng_min
            eng_min = eng_deploy;
            x_best = x_c;
            y_best = y_c;
        end
    end
    Population(i).xe = [x_best,y_best];
end
up_Population = Population;
end