function SG = creatSG()
% SG = struct('Y',[],'N',0,'M',0,...
%                     'k',8,'d',3,'n',14,'r',0,'S',0,'Pt_intra',60,'Pt_inter',40,...
%                     'f',1.07e10,'N0',1e-20,'B',2e7,'l_intra',8.7*10^6,'l_inter',2.175*10^7,'Gt',30,'Gr',50,...
%                     'C_intra',0,'C_inter',0,'alph',40,'tao_max',1.5,'c',3e8,'data_pos',[],'idle_pos',[]);
SG = struct('Y',[],'N',0,'M',0,...
                    'k',8,'d',3,'n',14,'r',0,'S',0,'Pt_intra',15,'Pt_inter',20,...
                    'f',1.25e10,'N0',4.14e-21,'B',2.5e8,'l_intra',2.1654*10^6,'l_inter',4.712*10^6,'Gt',17,'Gr',35,...
                    'C_intra',0,'C_inter',0,'alph',800,'tao_max',6.8,'c',3e8,'data_pos',[],'idle_pos',[]);

SG.Y = [0 0 0 0 1 0 0 1,0,0;  % 星座规模以及数据卫星位置
    0 0 0 0 0 0 0 0 0 0;
    0 0 1 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 1 0 0;
    0 0 0 1 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 1 0 0;
    0 0 0 1 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0;
    1 0 0 0 0 0 0 0 0 0];
% SG.Y = [0 0 0 0 1 0 0 1,;  % 星座规模以及数据卫星位置
%     0 0 0 0 0 0 0 0,;
%     0 0 1 0 0 0 0 0,;
%     0 0 0 0 0 0 0 1,;
%     0 0 0 1 0 0 0 0,;
%     0 0 0 0 0 1 0 0];
SG.k = sum(SG.Y,'all');
SG.r = SG.n - SG.k;
SG.N = size(SG.Y,1);
SG.M = size(SG.Y,2);
SG.S = SG.M * SG.N - SG.k;
[SG.C_intra,SG.C_inter] = count_C(SG);
[SG.data_pos,SG.idle_pos] = getpos(SG.Y,SG.N,SG.M);
end