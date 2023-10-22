function Offspring = Cross_variation(Population,SG)

N = length(Population);
for i=1:floor(N/2)
    P1 = Population(2*i-1).x;
    P2 = Population(2*i).x;
    
    [C1,C2] = Crossover(P1,P2); %交叉
    C1 = Mutation(C1,SG.S);%变异
    C2 = Mutation(C2,SG.S);
    
    Population(2*i-1).x = C1;
    Population(2*i).x = C2;
end
Offspring = Population;
Offspring = search_cpNode(SG,Offspring);%找每个个体对应的计算节点
Offspring = Total_eng(SG,Offspring); %计算交叉后的适应度
Offspring = penalty(SG,Offspring); %计算交叉后的罚函数
end