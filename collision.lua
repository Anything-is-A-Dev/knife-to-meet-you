function AABB(x,y,w,h,x2,y2,w2,h2)
    return x < x2+w2 and
           x+w > x2 and
           y < y2 + h2 and
           y+h > y2

end