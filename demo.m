%%
% matlab学位论文绘图辅助工具demo
% 作者：ztinpn
% 项目地址：https://github.com/ztinpn/utilForFormat
% 下载地址：https://github.com/ztinpn/utilForFormat/archive/master.zip

%% 复制前需要保证copy options已选择：
% preserve information
% transparent background
% match figure screen size

clear variables;
% clear classes;
close all;

%% 生成工具类对象 这句必须有，生成之后不用重复执行。
utilForFormat = UtilForFormat('on');
% on: 打开使用统计功能，大家可以在http://new.cnzz.com/v1/login.php?siteid=1254502417里（访客分析->地区\运营商）
% 查看本工具的全国用户使用情况
% off: 关闭使用统计功能

%% 默认字体相关
% 默认字体是'宋体', '10pt', 'bold'
% 可通过 utilForFormat.setDefaultFont('宋体', 10, 'bold');进行修改

%%
close all;
t = 0:0.05:1;
numOfLines = 8;
strCell = cell(1,numOfLines);

%% 自动样式
% (1) 颜色，标记，线型顺序

% 'cml': 先color，再 marker最后 line的顺序生成曲线样式
labelsForPlotLine = utilForFormat.labelsForPlotLineGnrt('cml');

figure;
hold on;
grid on;
for ia = 1:numOfLines
    plot(t, ia + sin(2 * pi * t), labelsForPlotLine{1,ia});
    strCell{1,ia} = sprintf('曲线%d',ia);
end
legend(strCell);
utilForFormat.setLineWidth(1.5); % 设置线宽
utilForFormat.dissertationPlot(...
    '样式优先级：颜色>标记>线型',... % 标题字符串
    'x轴',...
    'y轴',...
    7.5 ...   % 固定宽度，单位cm
    );
% (2) 样式优先级：标记>颜色>线型
labelsForPlotLine = utilForFormat.labelsForPlotLineGnrt('mcl');

figure;
hold on;
grid on;
for ia = 1:numOfLines
    plot(t, ia + sin(2 * pi * t), labelsForPlotLine{1,ia});
    strCell{1,ia} = sprintf('曲线%d',ia);
end
legend(strCell);
utilForFormat.setLineWidth(1.5);
utilForFormat.dissertationPlot('样式优先级：标记>颜色>线型','x轴','y轴',7.5);
%% 二维图
% 非自适应高度
xVec = 1:100;
yVec = 1:150;
figure;
imagesc(xVec,yVec,rand(length(yVec),length(xVec)));
axis equal;
xlim([min(xVec),max(xVec)]);
ylim([min(yVec),max(yVec)]);
utilForFormat.colorbarPlot('值[单位]');
utilForFormat.dissertationPlotNoAdjust(sprintf('10cm宽，非自适应\n缺点：两侧空白 '),'x轴','y轴',10);
% 自适应高度
figure;
imagesc(xVec,yVec,rand(length(yVec),length(xVec)));
axis equal;
xlim([min(xVec),max(xVec)]);
ylim([min(yVec),max(yVec)]);
utilForFormat.colorbarPlot('值[单位]');
utilForFormat.dissertationPlot('10cm宽，自适应','x轴','y轴',10);