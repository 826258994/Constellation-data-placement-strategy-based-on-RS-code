% SG.alph,SG.c,SG.tao_max,SG.l_intra,SG.l_inter,SG.Pt_intra,SG.Pt_inter,SG.C_intra,SG.C_inter,SG.M,SG.data_pos,SG.idle_pos,SG.d,SG.k,x
function up_Population = penalty(SG,Population)

%% 罚函数，降级读取时延超过约束上限的大小
for n = 1 : size(Population,2)
    tao_retrv = zeros(SG.M,1);
    parity = SG.idle_pos(Population(n).x,:);
    % 遍历下载轨道里的每个节点
    for i = 1 : SG.M
        diff_i = [abs([SG.d,i]-SG.data_pos);abs([SG.d,i]-parity)]; % 下载节点到所有数据块和校验块的距离
        % 要和计算降级读取能耗使用一样的选取方式
        d1 = [diff_i(:,1)*SG.Pt_inter/SG.C_inter,diff_i(:,2)*SG.Pt_intra/SG.C_intra];
        d1 = sum(d1,2);
        d2 = sort(d1);
        d2 = d2(1:SG.k);
        % 记录选中的k个节点的下标，找到它和下载节点的跳数关系
        %     for j = 1 : SG.k
        %   % 这么写会出现左右维度不同无法赋值的问题，当d1里有重复元素，刚好也在d2里，就会搜出1个以上的下标
        %         index_d(j) = find(d1 == d2(j));
        %     end
        index_z = false(1,size(d1,1));
        for j = 1 : SG.k
            index_d(j,:) = d1 == d2(j);
            index_z = index_z | index_d(j,:);
        end
        d3 = diff_i(index_z,:); %得到选中k个点与下载点的跳数关系
        
        % 计算k个点的降级读取时延，并选最大的一个作为第i个下载点的降级读取时延
        for j = 1 : size(d3,1)
            % 分条带，存储转发
            E = (d3(j,1)*SG.l_inter + d3(j,2)*SG.l_intra)/SG.c; %最后一个条带的传播时延
            if d3(j,1) == 0 %同轨卫星
                A = SG.alph/SG.C_intra;
                B = 2*SG.l_intra/SG.c;
                D = (d3(j,1)/SG.C_inter + d3(j,2)/SG.C_intra)*SG.alph;
                Z = max(round(sqrt((D-A)/B)),1); %最佳条带数，整数且至少为1
                tao_i(j) = (Z-1)*(A/Z + B) + D/Z + E;
            else %异轨卫星
                A = SG.alph/SG.C_inter;
                B = 2*SG.l_inter/SG.c;
                D = (d3(j,1)/SG.C_inter + d3(j,2)/SG.C_intra)*SG.alph;
                Z = max(round(sqrt((D-A)/B)),1); %最佳条带数，整数且至少为1
                tao_i(j) = (Z-1)*(A/Z + B) + D/Z + E;
            end
        end
        tao_retrv(i) = max(tao_i);
    end
    Population(n).penaty = sum(max(0,tao_retrv - SG.tao_max));
end
up_Population = Population;
end