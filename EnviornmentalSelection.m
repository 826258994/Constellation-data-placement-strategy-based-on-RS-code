function New_Population = EnviornmentalSelection(Population,Offspring,~)
% ������������ѡ�µ���Ⱥ

N = length(Population);
New_Population = Population;

%% ����˼·���£�Ϊ��ȷ����Ⱥ�Ķ����ԣ�����һ��һ�滻���ơ�ֻ�к������ǿ�ڸ����Żᷢ���滻��
for i=1:N
    p_penaty = Population(i).penaty;
    c_penaty = Offspring(i).penaty;
    p_fitness = Population(i).fitness;
    c_fitness = Offspring(i).fitness;
    if p_penaty == c_penaty % �����������ȾͱȽ���Ӧ��
        if p_fitness < c_fitness
            New_Population(i) = Population(i);
        else
            New_Population(i) = Offspring(i);
        end
    else                      % ������������Ⱦ�ѡ������С��
        if p_penaty < c_penaty
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

