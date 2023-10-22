% 输入：星座矩阵
% 输出：数据节点和空闲节点的坐标，按照从上到下，从左到右编号
function [data_pos, idle_pos] = getpos(Y,N,M)
n1 = 1;
n2 = 1;
for i = 1 : N
    for j = 1 : M
        if Y(i,j) == 1 %是数据节点
            data_pos(n1,:) = [i,j];
            n1 = n1 + 1;
        else
            idle_pos(n2,:) = [i,j];
            n2 = n2 + 1;
        end
    end
end
end