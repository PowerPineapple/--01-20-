function Master_ker!(r::Robot)
    num_Hor=moving!(r,HorizonSide(3)) #двигается к правой границе
    num_Vert=moving!(r,HorizonSide(2)) #двигается к нижней границе
    putmarkers!(r,HorizonSide(0))
    zigzag!(r)
    moving!(r,HorizonSide(3))
    moving!(r,HorizonSide(2))
    putmarker!(r)
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

zigzag!(r::Robot) = while isborder(r,HorizonSide(1)) == false
    move!(r,HorizonSide(1))
    putmarker!(r)
    putmarkers!(r,HorizonSide(2))
    moving!(r,HorizonSide(0))
end

movingback!(r::Robot, side::HorizonSide, num_steps::Int) = for i in 1:num_steps
    move!(r,side)
end

putmarkers!(r::Robot,side::HorizonSide) = while isborder(r,side)==false 
    move!(r,side)
    putmarker!(r)
end
