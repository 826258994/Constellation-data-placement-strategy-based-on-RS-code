function Population = Init(PopSize,S,r)
% 本函数用于构造初始解
pop.x = []; % 放置策略
pop.xe = [];% 计算节点位置
pop.fitness = [];% 适应度（总能耗）
pop.penaty = []; % 罚函数
Population = repmat(pop,1,PopSize);

for i=1:PopSize
    temp = randperm(S,r);
    Population(i).x = temp;
end
end

