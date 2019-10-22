function pt_udata = conv2udata(px_coord, ax_coord, ax_lim)

    frac_x = (px_coord(1)-ax_coord(1))/(ax_coord(3)-ax_coord(1));
    frac_y = (px_coord(2)-ax_coord(2))/(ax_coord(4)-ax_coord(2));
    
    pt_udata(1) = ax_lim(1)+ frac_x*(ax_lim(2)-ax_lim(1));
    pt_udata(2) = ax_lim(3)+ frac_y*(ax_lim(4)-ax_lim(3));
    