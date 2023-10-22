function X = Mutation(X,S)
% 本函数用于个体的变异
n = length(X);
PM = 1/n; %变异概率
if rand < PM
    r1 = 1 + round((n-1)*rand()); %随机选择一个变异位置
    diff = setdiff(randperm(S),X); %保证变异后不产生重复数字
    r2 = 1 + round((S-n-1)*rand()); %从无重复的数字里随机选一个作为变异后的数
    X(r1) = diff(r2);
end
end
