clear;
% Read the data.
fid  =  fopen('krkopt.DATA');
c = fread(fid, 3);

vec = zeros(6,1);
xapp = [];  % 接收六维的数据，先声明
yapp = [];  % 接收所有的标签，先声明

while ~feof(fid)
    string = [];
    c = fread(fid,1);
    flag = flag+1;
    while c~=13  % 13代表回车； // 这里是读一行
        string = [string, c];
        c=fread(fid,1);
    end    
    fread(fid,1);                % 这里是处理一行               
    if length(string)>10
        vec(1) = string(1) - 96; % 把a变为整数1；
        vec(2) = string(3) - 48;
        vec(3) = string(5) - 96;
        vec(4) = string(7) - 48;
        vec(5) = string(9) - 96;
        vec(6) = string(11) - 48;
        xapp = [xapp,vec];
        if string(13) == 100  % 13是因为第13个是draw（和棋）100是d；
            yapp = [yapp,1];
        else
            yapp = [yapp,-1];
        end
    end
end
fclose(fid);
%保存数字化后的数据
xlswrite('handled_data.xls',[xapp' yapp']);