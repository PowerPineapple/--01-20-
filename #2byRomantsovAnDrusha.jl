function around_n_comeback!(r::Robot)
    num_Hor=moving!(r,HorizonSide(3)) #двигается к правой границе
    num_Vert=moving!(r,HorizonSide(2)) #двигается к ЮВ углу
    for side in (HorizonSide(i) for i=0:3) #маркирует по контуру до ЮВ угла
        putmarkers!(r,side)
    end
    movingback!(r,HorizonSide(1), num_Hor)
    movingback!(r,HorizonSide(0), num_Vert) #вернулись в исхожную точку
end

function moving!(r::Robot,side::HorizonSide) 
    num_steps = 0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return(num_steps)
end

movingback!(r::Robot, side::HorizonSide, num_steps::Int) = for i in 1:num_steps
    move!(r,side)
end

putmarkers!(r::Robot,side::HorizonSide) = while isborder(r,side)==false 
    move!(r,side)
    putmarker!(r)
end
