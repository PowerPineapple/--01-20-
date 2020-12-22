function Heaven!(r::Robot)
    num_Hor=moving!(r,HorizonSide(3)) #двигается к правой границе
    num_Vert=moving!(r,HorizonSide(2)) #двигается к нижней границе
    Stair_Builder!(r)
    moving!(r,HorizonSide(3))
    moving!(r,HorizonSide(2))
    movingback!(r,HorizonSide(0), num_Vert)
    movingback!(r,HorizonSide(1), num_Hor) #вернулись в исходную точку
    
end

function moving!(r::Robot,side::HorizonSide) 
    num_steps = 0
    while (isborder(r,side)==false)
        move!(r,side)
        num_steps+=1
    end
    return(num_steps)
end

function Stair_Builder!(r::Robot)
    putmarkers!(r,HorizonSide(1))
    move_by_markers(r,HorizonSide(3)) 
    putmarker!(r)
    while isborder(r,HorizonSide(0))==false && isborder(r,HorizonSide(1))==false
        move!(r,HorizonSide(0))
        move!(r,HorizonSide(1))
        putmarkers!(r,HorizonSide(1))
        move_by_markers(r,HorizonSide(3))
        putmarker!(r)
    end
end

putmarkers!(r::Robot,side::HorizonSide) = while isborder(r,side)==false
    move!(r,side)
    putmarker!(r)
end

move_by_markers(r::Robot,side::HorizonSide) = while ismarker(r)==true && isborder(r,side)==false
    move!(r,side) 
end

movingback!(r::Robot, side::HorizonSide, num_steps::Int) = for i in 1:num_steps
    move!(r,side)
end