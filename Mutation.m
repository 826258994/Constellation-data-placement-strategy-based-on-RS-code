function X = Mutation(X,S)
% ���������ڸ���ı���
n = length(X);
PM = 1/n; %�������
if rand < PM
    r1 = 1 + round((n-1)*rand()); %���ѡ��һ������λ��
    diff = setdiff(randperm(S),X); %��֤����󲻲����ظ�����
    r2 = 1 + round((S-n-1)*rand()); %�����ظ������������ѡһ����Ϊ��������
    X(r1) = diff(r2);
end
end
