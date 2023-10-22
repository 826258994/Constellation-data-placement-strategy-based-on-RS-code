function [C1, C2] = Crossover(P1, P2)
% 本函数用于种群的交叉，总共设计两种交叉策略
n = length(P1);

pos = randperm(n,1); %这里每次交叉只挑选一个位置
C1 = P1; C2 = P2;

C1(pos) = P2(pos); C2(pos) = P1(pos);
% 处理交换后可能出现的重复元素
for i = 1 : n
    if i ~= pos && C1(i) == C1(pos)
        C1(i) = C2(pos);
    end
    if i ~= pos && C2(i) == C2(pos)
        C2(i) = C1(pos);
    end
end
end
