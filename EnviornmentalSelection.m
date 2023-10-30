function New_Population = EnviornmentalSelection(Population,Offspring,~)
% ������������ѡ�µ���Ⱥ

N = length(Population);
New_Population = Population;

%% ����˼·���£�Ϊ��ȷ����Ⱥ�Ķ����ԣ�����һ��һ�滻���ơ�ֻ�к������ǿ�ڸ����Żᷢ���滻��
for i=1:N
    p_penalty = Population(i).penalty;
    c_penalty = Offspring(i).penalty;
    p_fitness = Population(i).fitness;
    c_fitness = Offspring(i).fitness;
    if p_penalty == c_penalty % �����������ȾͱȽ���Ӧ��
        if p_fitness < c_fitness
            New_Population(i) = Population(i);
        else
            New_Population(i) = Offspring(i);
        end
    else                      % ������������Ⱦ�ѡ������С��
        if p_penalty < c_penalty
            New_Population(i) = Population(i);
        else
            New_Population(i) = Offspring(i);
        end
    end
end

% %% �˴����þ�Ӣ�������ԣ�ÿһ�ε���֮����ѡָ����������ѽ��滻���ӽ⣬���������ڸ��ʸ��ݵ������ȼ���
% objs = [New_Population.obj];
% cons = [New_Population.cons];
% [~,index] = sortrows([cons' objs']);
% n = ceil((1-state)*(N/100));
% if rand>state*state/2
%     New_Population(index(end-n+1:end)) = New_Population(index(1:n));
% end

