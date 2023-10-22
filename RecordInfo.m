obj = [Population.obj]; %��ȡ��Ⱥ��Ŀ��ֵ
cons = [Population.con]; %��ȡ��ȺΥ��Լ�������

%% ��¼����������Ϣ
min_obj = min(obj); [min_cons]=min(cons); mean_obj = mean(obj); mean_cons = mean(cons);
ConvergenceF(1,gen) = min_obj; ConvergenceCV(1,gen) = min_cons;
ConvergenceF(2,gen) = mean_obj; ConvergenceCV(2,gen) = mean_cons;
[~,index] = sortrows([cons' obj']);
BestInd(gen) = Population(index(1));

%% ��ʾ������Ϣ
if gen > 1 && mod(gen,2)==0
    disp(['��������: ', num2str(gen), ', ��СΥ��Լ��: ', num2str(BestInd(gen).con), ...
        ', ���Ŀ��ֵ: ', num2str(BestInd(gen).obj)]);
    if plt || gen/genation==1
        yyaxis left
        plot(1:gen, ConvergenceCV(2,1:gen),'-b','linewidth',2)
        ylabel('Υ��Լ���̶�')
        ylim([0, inf]);
        hold on
        yyaxis right
        ylabel('Ŀ�꺯��ֵ')
        plot(1:gen, ConvergenceF(2,1:gen),'-r','linewidth',2);
        plot(1:gen, [BestInd(1:gen).obj],'-c','linewidth',2)
        xlabel('��������')
        legend('ƽ��Υ��Լ��','ƽ��Ŀ��ֵ','��ѽ�Ŀ��ֵ','location','northoutside','Orientation','horizontal')
        drawnow;
        hold off
    end
end