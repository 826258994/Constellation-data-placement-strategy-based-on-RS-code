function Population = CalObj(Population)
% ���������ڼ�����Ⱥ�������Ӧ��
N = length(Population);

for i=1:N
   x = Population(i).decs;
   
   %% ����Ŀ�꺯��ֵ
   f = x(1)^2+x(2)^2;
   
   %% ����Լ��Υ�����
   old_con = 0;
   con = 0;
   detail = "";
   if x(1)+x(2) <= 1
       con = con + 1;
   end
   if con ~= old_con
       detail = detail+"Լ��1��";
       old_con = con;
   end
   
   if x(1)-x(2)>=2
       con = con + 1;
   end
   if con ~= old_con
       detail = detail+"Լ��2��";
       old_con = con;
   end
   
   if max(x)>10 || min(x)<-10
       con = con + 1;
   end
   if con ~= old_con
       detail = detail+"Խ�磻";
       old_con = con;
   end
   
   %% ��װ����
   Population(i).obj = f;
   Population(i).con = con;
   Population(i).detail = detail;
end