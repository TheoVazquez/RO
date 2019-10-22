function [x y] = my_ginput(color)

ptx = mean(get(gca,'xlim'));
pty = mean(get(gca,'ylim'));
hold on;
axis manual;
h = plot(ptx,pty,'+','Color',color,'MarkerSize',50,'LineWidth',2);
axis auto;
hold off;

set(gcf,'WindowButtonMotionFcn',@c_cursor);
set(gcf,'WindowButtonDownFcn',@get_pt)
    
    function c_cursor(src,evnt)
            tmp = get(gcf,'units');
            set(gcf,'units','pixels');
        fig_pos = get(gcf,'position');
            set(gcf,'units',tmp);
            
            tmp = get(gca,'units');
            set(gca,'units','pixels');
        ax_coord = get(gca,'position') + [fig_pos(1) fig_pos(2) 0 0];
        ax_coord(3:4) = ax_coord(3:4) + ax_coord(1:2);
            set(gca,'units',tmp);

            tmp = get(0,'units');
            set(0,'units','pixels');
        scrn_pt = get(0,'PointerLocation');
            set(0,'units',tmp);
        
        
        if(scrn_pt(1)>=ax_coord(1) && scrn_pt(1)<=ax_coord(3) && scrn_pt(2)>=ax_coord(2) && scrn_pt(2)<=ax_coord(4))
            hold on;
            axis manual;
            newpt = conv2udata(scrn_pt,ax_coord,axis);
            set(h,'XData',newpt(1));
            set(h,'YData',newpt(2));
            axis auto;
            hold off;
        end
    end

    function get_pt(src,evnt)
            tmp = get(gcf,'units');
            set(gcf,'units','pixels');
        fig_pos = get(gcf,'position');
            set(gcf,'units',tmp);
            
            tmp = get(gca,'units');
            set(gca,'units','pixels');
        ax_coord = get(gca,'position') + [fig_pos(1) fig_pos(2) 0 0];
        ax_coord(3:4) = ax_coord(3:4) + ax_coord(1:2);
            set(gca,'units',tmp);

            tmp = get(0,'units');
            set(0,'units','pixels');
        scrn_pt = get(0,'PointerLocation');
            set(0,'units',tmp);
        
        
        if(scrn_pt(1)>=ax_coord(1) && scrn_pt(1)<=ax_coord(3) && scrn_pt(2)>=ax_coord(2) && scrn_pt(2)<=ax_coord(4))
            tmp = get(gca,'CurrentPoint');
            x = tmp(1,1);
            y = tmp(1,2);
            set(gcf,'WindowButtonMotionFcn','');
            set(gcf,'WindowButtonDownFcn','');
            delete(h);
        end
    end
    waitfor(gcf,'WindowButtonDownFcn','');
end