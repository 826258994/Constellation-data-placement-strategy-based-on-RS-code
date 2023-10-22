% 输入：数据节点、校验节点、计算节点的坐标
% 输出：校验块获取、校验块分配、平均降级读取能耗之和
% SG.alph,SG.Pt_intra,SG.Pt_inter,SG.C_intra,SG.C_inter,SG.M,SG.data_pos,SG.idle_pos,SG.d,SG.k,x,xe
function up_Population = Total_eng(SG,Population)
%% 计算校验块获取能耗
% eng_gather = 0;
% for i = 1 : SG.k
%     eng_gather = eng_gather + ...
%     (abs(xe(1) - SG.data_pos(i,1))/c_inter +  abs(xe(2) - SG.data_pos(i,2))/c_intra)*SG.alph*Ps;
% end
for j = 1 : size(Population,2)
    %% 计算校验块部署能耗（获取+分配）
    parity = SG.idle_pos(Population(j).x,:);
    diff = [abs(Population(j).xe - SG.data_pos);abs(Population(j).xe - parity)];
    eng_deploy = sum(diff(:,1)*SG.Pt_inter/SG.C_inter + diff(:,2)*SG.Pt_intra/SG.C_intra)*SG.alph;
    %% 计算下载轨道每个节点的降级读取能耗及平均降级读取能耗
    eng_retrv = zeros(SG.M,1);
    % 遍历下载轨道里的每个节点
    for i = 1 : SG.M
        diff_i = [abs([SG.d,i]-SG.data_pos);abs([SG.d,i]-parity)]; % 下载节点到所有数据块和校验块的距离
        diff_i = [diff_i(:,1)*SG.Pt_inter/SG.C_inter,diff_i(:,2)*SG.Pt_intra/SG.C_intra];
        diff_i = sort(sum(diff_i,2));
        diff_i = diff_i(1:SG.k);
        eng_retrv(i) = sum(diff_i)*SG.alph;
    end
    eng_retrv_avg = sum(eng_retrv)/SG.M;
    %% 总能耗
    Population(j).fitness = eng_deploy + eng_retrv_avg;
end
up_Population = Population;
end