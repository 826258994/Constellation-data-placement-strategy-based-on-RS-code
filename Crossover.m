function [C1, C2] = Crossover(P1, P2)
% ������������Ⱥ�Ľ��棬�ܹ�������ֽ������
n = length(P1);

pos = randperm(n,1); %����ÿ�ν���ֻ��ѡһ��λ��
C1 = P1; C2 = P2;

C1(pos) = P2(pos); C2(pos) = P1(pos);
% ����������ܳ��ֵ��ظ�Ԫ��
for i = 1 : n
    if i ~= pos && C1(i) == C1(pos)
        C1(i) = C2(pos);
    end
    if i ~= pos && C2(i) == C2(pos)
        C2(i) = C1(pos);
    end
end
end
