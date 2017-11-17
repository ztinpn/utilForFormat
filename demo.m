%% 复制前需要保证copy options已选择：
%% preserve information
%% transparent background
%% match figure screen size

close all;

t = 0:0.05:1;
numOfLines = 8;
strCell = cell(1,numOfLines);

%% 自动样式
% (1) 颜色，标记，线型顺序

% 'cml': 先color，再 marker最后 line的顺序生成曲线样式
labelsForPlotLine = UtilForFormat.labelsForPlotLineGnrt('cml');

figure;
hold on;
grid on;
for ia = 1:numOfLines
    plot(t, ia + sin(2 * pi * t), labelsForPlotLine{1,ia});
    strCell{1,ia} = sprintf('曲线%d',ia);
end
legend(strCell);
UtilForFormat.setLineWidth(1.5); % 设置线宽
UtilForFormat.dissertationPlot(...
    '样式优先级：颜色>标记>线型',... % 标题字符串
    'x轴',...
    'y轴',... 
    7.5 ...   % 固定宽度，单位cm
);
% (2) 样式优先级：标记>颜色>线型
labelsForPlotLine = UtilForFormat.labelsForPlotLineGnrt('mcl');

figure;
hold on;
grid on;
for ia = 1:numOfLines
    plot(t, ia + sin(2 * pi * t), labelsForPlotLine{1,ia});
    strCell{1,ia} = sprintf('曲线%d',ia);
end
legend(strCell);
UtilForFormat.setLineWidth(1.5);
UtilForFormat.dissertationPlot('样式优先级：标记>颜色>线型','x轴','y轴',7.5);
%% 二维图
% 非自适应高度
xVec = 1:100;
yVec = 1:150;
figure;
imagesc(xVec,yVec,rand(length(yVec),length(xVec)));
axis equal;
xlim([min(xVec),max(xVec)]);
ylim([min(yVec),max(yVec)]);
UtilForFormat.colorbarPlot('值[单位]');
UtilForFormat.dissertationPlotNoAdjust(sprintf('10cm宽，非自适应\n缺点：两侧空白 '),'x轴','y轴',10);
% 自适应高度
figure;
imagesc(xVec,yVec,rand(length(yVec),length(xVec)));
axis equal;
xlim([min(xVec),max(xVec)]);
ylim([min(yVec),max(yVec)]);
UtilForFormat.colorbarPlot('值[单位]');
UtilForFormat.dissertationPlot('10cm宽，自适应','x轴','y轴',10);