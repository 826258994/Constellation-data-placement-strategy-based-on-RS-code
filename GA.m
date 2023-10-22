function GA_best = GA()
clear;clc;close all

%% ��������
PopSize = 200;
MaxGen = 200;
SG = creatSG();

%% ��ʼ��
Population = Init(PopSize,SG.S,SG.r); %��ʼ����Ⱥ����
Population = search_cpNode(SG,Population);%��ÿ�������Ӧ�ļ���ڵ�
Population = Total_eng(SG,Population); %�����ʼ��Ӧ��
Population = penalty(SG,Population); %�����ʼ������
%��ʼ����Ⱥ���Ÿ��壬��ʼ��Ӧ����ɺܴ�
G_best = Population(1);
G_best.fitness = 1e8;
epoch_best(1) = G_best; %ÿ�ε��������Ž�
%% ��ʼ�Ż����
for k = 1:MaxGen
    MatingPool = TournamentSelection(3,PopSize,[Population.penaty],[Population.fitness]); %��ѡ����
    Offspring = Cross_variation(Population(MatingPool),SG); %���н������������õ�����������Ӵ�
    %�Ӹ����ͽ�����Ӵ�����ѡ�����µ��Ӵ��������Ӵ��ȸ������þ͸��¸��������򲻸���
    Population = EnviornmentalSelection(Population,Offspring,k/MaxGen); 
    %������Լ�������ĸ���������Ӧ����С��
    index1 = [Population.penaty] == 0; 
    Population_suit = Population(index1);
    if ~isempty(Population_suit)
        [~,index2] = sort([Population_suit.fitness]);
        if Population_suit(index2(1)).fitness < G_best.fitness
            G_best = Population_suit(index2(1));
        end
    end
    epoch_best(k) = G_best;
    disp(['��',num2str(k),'�ε���',newline,'Ŀǰ������Ӧ��Ϊ��',num2str(G_best.fitness),newline,...
        '��Ӧ���ò���Ϊ��',num2str(G_best.x),newline,'����ڵ�Ϊ��',num2str(G_best.xe)]);
end
GA_best = epoch_best;
end