function Population = CalObj(Population)
% 本函数用于计算种群个体的适应度
N = length(Population);

for i=1:N
   x = Population(i).decs;
   
   %% 计算目标函数值
   f = x(1)^2+x(2)^2;
   
   %% 计算约束违反情况
   old_con = 0;
   con = 0;
   detail = "";
   if x(1)+x(2) <= 1
       con = con + 1;
   end
   if con ~= old_con
       detail = detail+"约束1；";
       old_con = con;
   end
   
   if x(1)-x(2)>=2
       con = con + 1;
   end
   if con ~= old_con
       detail = detail+"约束2；";
       old_con = con;
   end
   
   if max(x)>10 || min(x)<-10
       con = con + 1;
   end
   if con ~= old_con
       detail = detail+"越界；";
       old_con = con;
   end
   
   %% 封装数据
   Population(i).obj = f;
   Population(i).con = con;
   Population(i).detail = detail;
end