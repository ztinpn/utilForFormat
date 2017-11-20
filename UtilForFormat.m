% matlab学位论文绘图辅助工具类
% 作者：ztinpn
% 项目地址：https://github.com/ztinpn/utilForFormat
% 下载地址：https://github.com/ztinpn/utilForFormat/archive/master.zip

classdef UtilForFormat < handle
    properties
        fontsize
        fontname
        fontweight
        version
    end
    methods
        % 宋体，bold, 10
        % utilForFormat = UtilForFormat('宋体', 10, 'bold')
        function utilForFormat = setDefaultFont(utilForFormat, fontname, fontsize, fontweight)
            utilForFormat.fontsize = fontsize;
            utilForFormat.fontname = fontname;
            utilForFormat.fontweight = fontweight;
        end
        function utilForFormat = UtilForFormat(checkUpdate)
            % http://rrss.sinaapp.com/static/html/utilforformat.html?v=1.0
            utilForFormat.version = 1;
            switch checkUpdate
                case 'on'
                    try
                        ie = actxserver('internetexplorer.application');
                        ie.Navigate('http://rrss.sinaapp.com/static/html/utilforformat.html?v=1.0');
                    catch
                        
                    end
                case 'off'
            end
            utilForFormat.setDefaultFont('宋体', 10, 'bold');
        end
        function setFont(utilForFormat,h)
            set(h,'fontname',utilForFormat.fontname);
            set(h,'fontweight',utilForFormat.fontweight);
            set(h,'fontsize',utilForFormat.fontsize)
        end
        function h = colorbarPlot(utilForFormat,titleString)
            h = colorbar;
            h_title = get(h,'title');
            set(h_title,'string',titleString);
            utilForFormat.setFont(h_title);
        end
        
        function dissertationPlotCore3d(utilForFormat,titleStr,xtitle,ytitle,ztitle, width_in_cm)
            utilForFormat.setFont(title(titleStr));
            utilForFormat.setFont(xlabel(xtitle));
            utilForFormat.setFont(ylabel(ytitle));
            utilForFormat.setFont(zlabel(ztitle));
            
            set(gcf,'units','centimeters');
            position_gcf = get(gcf,'position');
            width_2_division = width_in_cm;%10;7.8;
            ratio = position_gcf(1,3)/width_2_division;
            % ratio = [1,1,ratio,ratio];
            % set(gca,'position',[0 0 position(1,3:4)/ratio]);
            set(gcf,'position',[position_gcf(1,1:2) position_gcf(1,3:4)/ratio]);
            %             utilForFormat.cutPadding();
            %             set(gca,'units','centimeters');
        end
        function dissertationPlotCore(utilForFormat,titleStr,xtitle,ytitle,width_in_cm)
            utilForFormat.setFont(title(titleStr));
            utilForFormat.setFont(xlabel(xtitle));
            utilForFormat.setFont(ylabel(ytitle));
            
            set(gcf,'units','centimeters');
            position_gcf = get(gcf,'position');
            width_2_division = width_in_cm;%10;7.8;
            ratio = position_gcf(1,3)/width_2_division;
            % ratio = [1,1,ratio,ratio];
            % set(gca,'position',[0 0 position(1,3:4)/ratio]);
            set(gcf,'position',[position_gcf(1,1:2) position_gcf(1,3:4)/ratio]);
            %             utilForFormat.cutPadding();
            %             set(gca,'units','centimeters');
        end
        function dissertationPlot3d(utilForFormat,titleStr,xtitle,ytitle,ztitle,width_in_cm)
            utilForFormat.dissertationPlotCore3d(titleStr,xtitle,ytitle,ztitle,width_in_cm);
            iter_times = 1;
            for i_iter = 1:iter_times
                ratio_w2h = utilForFormat.getWidthToHeightRatio();
                %             position_gca = get(gca,'position');
                %             ratio_ax = position_gca(1,3) / position_gca(1,4);
                position_gcf = get(gcf,'position');
                set(gcf,'position',[position_gcf(1,1:3) position_gcf(1,3)/ratio_w2h]);
            end
            utilForFormat.moveToScreenCenter();
        end
        function dissertationPlot(utilForFormat,titleStr,xtitle,ytitle,width_in_cm)
            utilForFormat.dissertationPlotCore(titleStr,xtitle,ytitle,width_in_cm);
            iter_times = 1;
            for i_iter = 1:iter_times
                ratio_w2h = utilForFormat.getWidthToHeightRatio();
                %             position_gca = get(gca,'position');
                %             ratio_ax = position_gca(1,3) / position_gca(1,4);
                position_gcf = get(gcf,'position');
                set(gcf,'position',[position_gcf(1,1:3) position_gcf(1,3)/ratio_w2h]);
            end
            utilForFormat.moveToScreenCenter();
        end
        function dissertationPlotNoAdjust(utilForFormat,titleStr,xtitle,ytitle,width_in_cm)
            utilForFormat.dissertationPlotCore(titleStr,xtitle,ytitle,width_in_cm);
            utilForFormat.moveToScreenCenter();
        end
        function setLineWidth(utilForFormat,lineWidth)
            lineArr = utilForFormat.getObjectHandlersByType(gca,'line');
            for ia = 1:length(lineArr)
                set(lineArr(ia),'linewidth',lineWidth);
            end
        end
    end
    methods (Static)
        function demo()
            utilForFormat = UtilForFormat();
            t = 0:0.05:1;
            strCell = cell(1,10);
            
            % 'cml': 先color，再 marker最后 line的顺序生成曲线样式
            labelsForPlotLine = utilForFormat.labelsForPlotLineGnrt('cml');
            
            figure;
            hold on;
            grid on;
            for ia = 1:10
                plot(t, ia + sin(2 * pi * t), labelsForPlotLine{1,ia});
                strCell{1,ia} = sprintf('曲线%d',ia);
            end
            legend(strCell);
            utilForFormat.setLineWidth(1.5);
            utilForFormat.dissertationPlot('标题','x轴','y轴',10);
            xVec = 1:100;
            yVec = 1:200;
            figure;
            imagesc(xVec,yVec,rand(length(yVec),length(xVec)));
            axis equal;
            xlim([min(xVec),max(xVec)]);
            ylim([min(yVec),max(yVec)]);
            utilForFormat.colorbarPlot('值[单位]');
            utilForFormat.dissertationPlotNoAdjust('非自适应','x轴','y轴',10);
            figure;
            imagesc(xVec,yVec,rand(length(yVec),length(xVec)));
            axis equal;
            xlim([min(xVec),max(xVec)]);
            ylim([min(yVec),max(yVec)]);
            utilForFormat.colorbarPlot('值[单位]');
            utilForFormat.dissertationPlot('自适应','x轴','y轴',10);
        end
        
        %%
        function f=getObjectHandlersByType(objHandler,type)
            list=allchild(objHandler);
            cnt=0;
            f=[];
            for ix=1:length(list)
                if strcmp(get(list(ix),'Type'),type)==1
                    cnt=cnt+1;
                    f(cnt)=list(ix);
                end
            end
        end
        function labelsForPlotLine = labelsForPlotLineGnrt(ords)
            clrs={'b','r','k','g','m'};%5
            lines={'-',':','-.','--'};%4
            markers={'','o','x','+','*',...
                's','d','v','p','h','^','<','>','.'}; % 14
            len_clr=length(clrs);
            len_line=length(lines);
            len_marker=length(markers);
            labelsForPlotLine=cell(1,len_clr*len_line*len_marker);
            cnt = 0;
            switch ords
                case 'mlc'
                    for i3 = 1:len_clr
                        for i2 = 1:len_line
                            for i1 = 1:len_marker
                                cnt = cnt + 1;
                                labelsForPlotLine{1,cnt}=[markers{1,i1},lines{1,i2},clrs{1,i3}];
                            end
                        end
                    end
                case 'lmc'
                    for i3 = 1:len_clr
                        for i1 = 1:len_marker
                            for i2 = 1:len_line
                                cnt = cnt + 1;
                                labelsForPlotLine{1,cnt}=[markers{1,i1},lines{1,i2},clrs{1,i3}];
                            end
                        end
                    end
                case 'mcl'
                    for i2 = 1:len_line
                        for i3 = 1:len_clr
                            for i1 = 1:len_marker
                                cnt = cnt + 1;
                                labelsForPlotLine{1,cnt}=[markers{1,i1},lines{1,i2},clrs{1,i3}];
                            end
                        end
                    end
                case 'cml'
                    for i2 = 1:len_line
                        for i1 = 1:len_marker
                            for i3 = 1:len_clr
                                cnt = cnt + 1;
                                labelsForPlotLine{1,cnt}=[markers{1,i1},lines{1,i2},clrs{1,i3}];
                            end
                        end
                    end
                case 'lcm'
                    for i1 = 1:len_marker
                        for i3 = 1:len_clr
                            for i2 = 1:len_line
                                cnt = cnt + 1;
                                labelsForPlotLine{1,cnt}=[markers{1,i1},lines{1,i2},clrs{1,i3}];
                            end
                        end
                    end
                case 'clm'
                    for i1 = 1:len_marker
                        for i2 = 1:len_line
                            for i3 = 1:len_clr
                                cnt = cnt + 1;
                                labelsForPlotLine{1,cnt}=[markers{1,i1},lines{1,i2},clrs{1,i3}];
                            end
                        end
                    end
            end
        end
        function cutPadding()
            ax = gca;
            set(ax,'units','centimeters');
            outerpos = get(ax,'OuterPosition');
            ti = get(ax,'TightInset');
            left = outerpos(1) + ti(1);
            bottom = outerpos(2) + ti(2);
            ax_width = outerpos(3) - ti(1) - ti(3);
            ax_height = outerpos(4) - ti(2) - ti(4);
            set(ax,'Position',[left bottom ax_width ax_height]);
        end
        function ratio = getWidthToHeightRatio()
            %             pause(0.5);
            frame = getframe(gcf);
            im = frame.cdata;
            im = double(rgb2gray(im));
            [mm,nn,zz] = size(im);
            upper = 1;
            bgcolor = im(1,1);
            for ia = 1:mm
                if ~(im(ia,1) == bgcolor && var(im(ia,:)) == 0)
                    break;
                end
            end
            upper = ia - 1;
            for ia = 1:mm
                if ~(im(mm - ia + 1,1) == bgcolor && var(im(mm - ia + 1,:)) == 0)
                    break;
                end
            end
            lower = mm - ia + 1;
            for ir = 1:nn
                if ~(im(1,ir) == bgcolor && var(im(:,ir)) == 0)
                    break;
                end
            end
            left = ir - 1;
            for ir = 1:nn
                if ~(im(1,nn - ir + 1) == bgcolor && var(im(:,nn - ir + 1)) == 0)
                    break;
                end
            end
            right = nn - ir + 1;
            display(sprintf('%d %d %d %d',upper, lower, left, right));
            width = right - left + 1;
            height = lower - upper + 1;
            ratio = width / height;
        end
        function moveToScreenCenter()
            pos = get(0,'MonitorPosition');
            set(gcf,'units','pixel');
            pos_gcf = get(gcf,'position');
            left = (pos(1,3) - pos_gcf(1,3)) / 2;
            top = (pos(1,4) - pos_gcf(1,4)) / 2;
            set(gcf,'position',[left top pos_gcf(3:4)]);
        end
    end
end