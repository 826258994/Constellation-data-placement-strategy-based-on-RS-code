function Population = Init(PopSize,S,r)
% ���������ڹ����ʼ��
pop.x = []; % ���ò���
pop.xe = [];% ����ڵ�λ��
pop.fitness = [];% ��Ӧ�ȣ����ܺģ�
pop.penaty = []; % ������
Population = repmat(pop,1,PopSize);

for i=1:PopSize
    temp = randperm(S,r);
    Population(i).x = temp;
end
end

