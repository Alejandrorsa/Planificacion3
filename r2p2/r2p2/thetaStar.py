
import path_planning as pp

def checkObst(pos_x, pos_y, grid):   
    return (grid[pos_x][pos_y].value >= 5)
    

def lineOfSigth(s1, s2, grid):
    x0=s1.grid_point[0]
    y0=s1.grid_point[1]
    x1=s2.grid_point[0]
    y1=s2.grid_point[1]

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
                if checkObst(x0+((sx-1)/2), y0+((sy-1)/2), grid):
                    return False
                y0=y0+sy
                f=f-dx
            if f!=0 & checkObst(x0+((sx-1)/2), y0+((sy-1)/2), grid):
                return False
            if dy==0 & checkObst(x0+((sx-1)/2), y0 , grid) & checkObst(x0+((sx-1)/2), y0-1 , grid):
                return False
            x0=x0+sx
    else:
        while y0!=y1:
            f=f+dx
            if f>=dy:
                if checkObst(x0+((sx-1)/2), y0+((sy-1)/2), grid):
                    return False
                x0=x0+sx
                f=f-dy
            if f!=0 & checkObst(x0+((sx-1)/2), y0+((sy-1)/2), grid):
                return False   
            if dy==0 & checkObst(x0, y0+((sy-1)/2), grid) & checkObst(x0-1, y0+((sy-1)/2), grid):
                return False  
            y0=y0+sy   


def children(point,grid):    
    x,y = point.grid_point
    if x > 0 and x < len(grid) - 1:
        if y > 0 and y < len(grid[0]) - 1:
            links = [grid[d[0]][d[1]] for d in\
                     [(x-1, y),(x,y - 1),(x,y + 1),(x+1,y),\
                      (x-1, y-1), (x-1, y+1), (x+1, y-1),\
                      (x+1, y+1)]]
        elif y > 0:
            links = [grid[d[0]][d[1]] for d in\
                     [(x-1, y),(x,y - 1),(x+1,y),\
                      (x-1, y-1), (x+1, y-1)]]
        else:
            links = [grid[d[0]][d[1]] for d in\
                     [(x-1, y),(x,y + 1),(x+1,y),\
                      (x-1, y+1), (x+1, y+1)]]
    elif x > 0:
        if y > 0 and y < len(grid[0]) - 1:
            links = [grid[d[0]][d[1]] for d in\
                     [(x-1, y),(x,y - 1),(x,y + 1),\
                      (x-1, y-1), (x-1, y+1)]]
        elif y > 0:
            links = [grid[d[0]][d[1]] for d in\
                     [(x-1, y),(x,y - 1),(x-1, y-1)]]
        else:
            links = [grid[d[0]][d[1]] for d in\
                     [(x-1, y), (x,y + 1), (x-1, y+1)]]
    else:
        if y > 0 and y < len(grid[0]) - 1:
            links = [grid[d[0]][d[1]] for d in\
                     [(x+1, y),(x,y - 1),(x,y + 1),\
                      (x+1, y-1), (x+1, y+1)]]
        elif y > 0:
            links = [grid[d[0]][d[1]] for d in\
                     [(x+1, y),(x,y - 1),(x+1, y-1)]]
        else:
            links = [grid[d[0]][d[1]] for d in\
                     [(x+1, y), (x,y + 1), (x+1, y+1)]]
    return [link for link in links if link.value != 9]


def updateVertex(current,node,openset,closedset,heur,goal,grid):
    if lineOfSigth(current.parent, node ,grid):
        if (current.parent.G + current.parent.move_cost(node))< node.G:
            node.G=current.parent.G + current.parent.move_cost(node)
            node.parent=current.parent
            if node in openset:
                openset.remove(node)
            openset.add(node)
    else:
        if (current.G + current.move_cost(node)) < node.G:
            node.G=current.G + current.move_cost(node)
            node.parent=current
            if node in openset:
                openset.remove(node)
            openset.add(node)

def thetaStar(start, goal, grid, heur='naive'):    
    #The open and closed sets
    openset = set()
    closedset = set()
    #Current point is the starting point
    current = start
    #Add the starting point to the open set
    openset.add(current)
    #While the open set is not empty
    while openset:
        #Find the item in the open set with the lowest G + H score
        current = min(openset, key=lambda o:o.G + o.H)
        pp.expanded_nodes += 1
        #If it is the item we want, retrace the path and return it
        if current == goal:
            path = []
            while current.parent:
                path.append(current)
                current = current.parent
            path.append(current)
            return path[::-1]
        #Remove the item from the open set
        openset.remove(current)
        #Add it to the closed set
        closedset.add(current)
        #Loop through the node's children/siblings
        for node in children(current,grid):
            #If it is already in the closed set, skip it
            if node in closedset:
                continue
            #Otherwise if it is already in the open set
            if node in openset:                
                updateVertex(current,node,openset,closedset,heur,goal,grid)                
            else:
                if current.parent is not None:
                    if lineOfSigth(current.parent, node, grid):
                        #If it isn't in the open set, calculate the G and H score for the node
                        node.G = current.G + current.move_cost(node)
                        node.H = pp.heuristic[heur](node, goal)
                        #Set the parent to our current item
                        node.parent = current
                        #Add it to the set
                        openset.add(node)
    #Throw an exception if there is no path
    raise ValueError('No Path Found')

pp.register_search_method('Theta*', thetaStar)