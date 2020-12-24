function Whatson!(r::Robot)
    Num = 0
    Rounder!(r,Num)
end

function Rounder!(r::Robot, step::Int)
    found = false
    direction = 3
    while(found == false)
        direction = mod((direction + 1),4)
        step = step + mod(direction,2)
        found = searcher_line!(r,HorizonSide(direction),step)
    end
    searcher_point!(r,direction)
end

function searcher_line!(r::Robot,side::HorizonSide,num_steps::Int)
    flag=false
    for i in 1:num_steps
        move!(r,side)
        if ismarker(r)==true
            flag=true
        end
    end
    return(flag)
end

function searcher_point!(r::Robot,side::Int)
    side = mod((side + 2),4)
    while (ismarker(r) == false)
        move!(r,HorizonSide(side))
    end
end