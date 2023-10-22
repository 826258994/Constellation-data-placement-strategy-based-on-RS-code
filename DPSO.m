function DPSO_best = DPSO()
% 离散粒子群算法，把x改成r个1-S内的整数
clc;
clear;
tic;%记录开始时间
%% 定义参数
SG = creatSG();
err = 1e-6; %罚函数误差范围
particle_size = 200; %粒子数量
w_max = 0.8; %速度惯性因子
c1 = 2; %自我学习因子
c2 = 2; %群体学习因子
T = 200; %最大迭代次数
V_max = 5; %最大速度
V_min = -V_max;

%% 初始化
Population = Init(particle_size,SG.S,SG.r); %初始化种群个体
Population = search_cpNode(SG,Population);%找每个个体对应的计算节点
Population = Total_eng(SG,Population); %计算初始适应度
Population = penalty(SG,Population); %计算初始罚函数
%初始化种群最优个体，初始适应度设成很大
G_best = Population(1);
G_best.fitness = 1e8;
%初始化个体最优
P_best = Population;
epoch_best(1) = G_best; %每次迭代的最优解
v = 10*rand(particle_size,SG.r)-5;
%% 开始迭代
iter = 1;
while iter <= T
    % 选取个体最优适应度及位置
    for i = 1 : particle_size %遍历种群里的粒子
        % 情况1，当前粒子和历史都满足约束条件，直接比较适应度大小
        if P_best(i).penaty <= err && Population(i).penaty <= err
            if Population(i).fitness < P_best(i).fitness
                P_best(i) = Population(i);
            end
        end
        % 情况2，历史可行，当前不可行，不执行操作（选历史）
        if P_best(i).penaty <= err && Population(i).penaty > err   
        end
        % 情况3，当前可行，历史不可行，选当前
        if P_best(i).penaty > err && Population(i).penaty <= err  
            P_best(i) = Population(i);
        end
        % 情况4，当前和历史都不可行，选罚函数小的
        if P_best(i).penaty > err && Population(i).penaty > err  
            if Population(i).penaty < P_best(i).penaty
                P_best(i) = Population(i);
            end 
        end
    end
    % 选取群体最优适应度及位置
    % 情况1，都满足约束，找最佳适应度
    if G_best.penaty <= err && min([P_best.penaty]) <= err 
        index1 = [P_best.penaty] == 0;
        Pbst_suit = P_best(index1);
        if ~isempty(Pbst_suit)
            [~,index2] = sort([Pbst_suit.fitness]);
            if Pbst_suit(index2(1)).fitness < G_best.fitness
                G_best = Pbst_suit(index2(1));
            end
        end
    end
    % 情况2，历史全局不满足约束条件，局部里有满足的，直接用局部里适应度最佳的粒子替代群体最佳
    if G_best.penaty > err && min([P_best.penaty]) <= err 
        index1 = [P_best.penaty] == 0;
        Pbst_suit = P_best(index1);
        if ~isempty(Pbst_suit)
            [~,index2] = sort([Pbst_suit.fitness]);
            G_best = Pbst_suit(index2(1));
        end
    end
    % 情况3，历史种群最佳满足，当前局部不满足，不做更新
    % 情况4，都不满足约束条件，选罚函数小的
    if G_best.penaty > err && min([P_best.penaty]) > err 
        [p_e, i_m] = min([P_best.penaty]);
        if p_e < G_best.penaty
            G_best = P_best(i_m);
        end
    end
    
    % 更新速度和位置
    %w = w_max-w_max*(iter/T);%使w的值随迭代次数增大不断递减，提高其局部搜索能力，加快收敛
    w_start = 0.9; w_end = 0.4; k_control = 0.6;
    w = (w_start - w_end) * tan(0.875*(1-(iter/T)^k_control)) + w_end;
    for i = 1 : particle_size
        x(i,:) = Population(i).x;
        partbest_x(i,:) = P_best(i).x;
    end
    v = w*v + c1*rand*(partbest_x - x) + c2*rand*(G_best.x - x); % 速度更新公式
    % 调整速度越界粒子
    v(v > V_max) = V_max;
    v(v < V_min) = V_min;
    % 更新x
    x = x + round(v);
    % 对x进行限制，保证其正确性，即策略有效性——数值为1-S内的整数且每个个体不能有重复数值
    x(x < 1) = 1;
    x(x > SG.S) = SG.S;
    % 保证数值唯一性
    for i = 1:particle_size
        uni_xi = unique(x(i,:));
        while numel(uni_xi) < SG.r
            missing_values = setdiff(1:SG.S, uni_xi);
            add_value = missing_values(randi(length(missing_values)));
            uni_xi(end+1) = add_value;
        end
        x(i,:) = uni_xi;
    end
    
    for i = 1 : particle_size
        Population(i).x = x(i,:);
    end
    
    str1 = ['第 ',num2str(iter),' 次迭代'];
    str2 = ['最佳策略为： ',num2str(G_best.x),'，对应计算节点坐标为：',num2str(G_best.xe)];
    str3 = ['最佳适应度为：',num2str(G_best.fitness)];
    disp(str1);
    disp(str2);
    disp(str3);
    epoch_best(iter) = G_best;
    % 计算新的适应度和罚函数
    Population = search_cpNode(SG,Population);%找每个个体对应的计算节点
    Population = Total_eng(SG,Population); %计算初始适应度
    Population = penalty(SG,Population); %计算初始罚函数
    iter = iter + 1;
end

elapsed_time = toc;
disp(['程序执行时间为：',num2str(elapsed_time),'秒']);
DPSO_best = epoch_best;
end