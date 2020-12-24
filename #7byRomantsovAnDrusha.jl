function Chesster!(r::Robot)
    num_Hor=moving!(r,HorizonSide(3)) #двигается к правой границе
    num_Vert=moving!(r,HorizonSide(2))
    kuda=mod(num_Hor+num_Vert,2)
    flag = false
    phonker(r,kuda,flag)
    moving!(r,HorizonSide(3))
    movingback!(r,HorizonSide(0), num_Vert)
    movingback!(r,HorizonSide(1), num_Hor)
end

phonker(r::Robot, kuda::Int, flag::Bool) = while(flag==false)
    first_step(r,kuda)
    engine!(r)
    moving!(r,HorizonSide(2))
    kuda=mod(kuda+1,2)
    if (isborder(r,HorizonSide(1))==false)
        move!(r,HorizonSide(1))
    else 
        flag = true
    end
end

function first_step(r::Robot,kuda::Int)
    if (kuda==1) && (isborder(r,HorizonSide(0))==false)
        move!(r,HorizonSide(0))
        putmarker!(r)
    end
    if kuda==0
        putmarker!(r)
    end
end

engine!(r) = while isborder(r,HorizonSide(0))==false
    move!(r,HorizonSide(0))
    if isborder(r,HorizonSide(0))==false
        move!(r,HorizonSide(0))
        putmarker!(r)
    end
end

function moving!(r::Robot,side::HorizonSide) 
    num_steps = 0
    while (isborder(r,side)==false)
        move!(r,side)
        num_steps+=1
    end
    return(num_steps)
end

movingback!(r::Robot, side::HorizonSide, num_steps::Int) = for i in 1:num_steps
    move!(r,side)
end