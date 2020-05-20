
def LineOfSigth(s1, s2, grid):
    x0, y0=s1.grid_point
    x1, y1=s2.grid_point

    dy=y1-y0
    dx=x1-x0
    f=0
    if dy<0:
        dy=-dy
        sy=-1
    else:
        sy=1
    if dx<0:
        dx=-dx
        dx=-1
    else:
        sx=1
    
    if dx>=dy:
        while x0!=x1:
            f=f+dy
            if f>=dx:
                if grid(x0+((sx-1)/2),):
                    return False
                y0=y0+sy
                f=f-dx
            if f!=0
