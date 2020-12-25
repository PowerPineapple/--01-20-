function Giant_Chess!(r::Robot, n::Int)
    num_Hor=moving!(r,HorizonSide(1))
    num_Vert=moving!(r,HorizonSide(2))
    Painter!(r,n)
    moving!(r,HorizonSide(2))
    movingback!(r,HorizonSide(3), num_Hor)
    movingback!(r,HorizonSide(0), num_Vert)
end

function Painter!(r::Robot, m::Int)
    flag = false
    height=0
    while flag == false
        space=div(height,m) * m
        Horizontalka!(r,m,space)
        if isborder(r, HorizonSide(0)) == 1
            flag = true
        else
            move!(r,HorizonSide(0))
        end
        height=height+1
    end
end

function Horizontalka!(r::Robot, k::Int, step::Int)
    flag = false
    while flag == false
        if mod(div(step,k),2) == 0
            putmarker!(r)
        end
        if isborder(r, HorizonSide(3)) == 1
            flag = true
        else
            move!(r,HorizonSide(3))
            step = step + 1
        end
    end
    moving!(r,HorizonSide(1))
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