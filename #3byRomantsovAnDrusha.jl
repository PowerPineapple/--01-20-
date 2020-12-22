function find_n_mark_it!(r::Robot)
    num_Hor=moving!(r,HorizonSide(3)) #двигается к правой границе
    num_Vert=moving!(r,HorizonSide(2)) #двигается к нижней границе
    num_Hor2=moving!(r, HorizonSide(3)) #ЮВ угол
    while isborder(r,HorizonSide(1))==false
        searching!(r,HorizonSide(0))
        searching!(r,HorizonSide(2))
        if isborder(r,HorizonSide(1))==0
            move!(r,HorizonSide(1))
        end
    end
    for side in 0:3 #маркирует по контуру до ЮВ угла
        putmarkers_byside!(r,side)
        putmarker!(r)
        move!(r,HorizonSide(mod(side+1,4)))
    end
    moving!(r,HorizonSide(3))
    moving!(r,HorizonSide(2))
    movingback!(r,HorizonSide(1), num_Hor2)
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

searching!(r::Robot,side::HorizonSide) = while (isborder(r,side)==false) && (isborder(r,HorizonSide(1))==false)
    move!(r,side)
end

movingback!(r::Robot, side::HorizonSide, num_steps::Int) = for i in 1:num_steps
    move!(r,side)
end

putmarkers_byside!(r::Robot,side::Int) = while isborder(r,HorizonSide(mod(side+1,4))) 
    putmarker!(r)
    move!(r,HorizonSide(side))
end