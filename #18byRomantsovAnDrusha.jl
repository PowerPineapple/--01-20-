function Ugolovnik_2!(r::Robot)
    Map=move_to_the_corner!(r)
    Going_for_a_walk!(r)
    comeback!(r,Map)    
end


function move_to_the_corner!(r::Robot)
    Way=[]
    while (isborder(r, HorizonSide(3))==false) || (isborder(r,HorizonSide(2))==false)
        push!(Way,moving!(r,HorizonSide(3)))
        push!(Way,moving!(r,HorizonSide(2)))
    end
    return(Way)
end

Going_for_a_walk!(r::Robot) = for side in (HorizonSide(i) for i=0:3)
    moving!(r,side)
    putmarker!(r)
end

comeback!(r::Robot,Wayback::Any) = while length(Wayback)>0
    movingback!(r,HorizonSide(0),Wayback[end])
    pop!(Wayback)
    movingback!(r,HorizonSide(1),Wayback[end])
    pop!(Wayback)
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
