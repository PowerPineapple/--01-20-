function Sider!(r::Robot)
    Map, HorSum, VertSum=move_to_the_corner1!(r)
    Going_for_a_walk!(r, HorSum, VertSum)
    comeback!(r,Map)    
end


function move_to_the_corner1!(r::Robot)
    Way=[]
    HorSum=0
    VertSum=0
    while (isborder(r, HorizonSide(3))==false) || (isborder(r,HorizonSide(2))==false)
        push!(Way,moving!(r,HorizonSide(3)))
        HorSum=HorSum+Way[end]
        push!(Way,moving!(r,HorizonSide(2)))
        VertSum=VertSum+Way[end]
    end
    return(Way, HorSum, VertSum)
end

function Going_for_a_walk!(r::Robot, HorSum::Int, VertSum::Int)
    MaxVert=SpecialMoving!(r,HorizonSide(0),VertSum)
    MaxHor=SpecialMoving!(r,HorizonSide(1),HorSum)
    SpecialMoving!(r,HorizonSide(2),MaxVert-VertSum)
    SpecialMoving!(r,HorizonSide(3),MaxHor-HorSum)
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

function SpecialMoving!(r::Robot, side::HorizonSide, steps)
    num_steps = 0
    while (isborder(r,side)==false)
        move!(r,side)
        num_steps+=1
        if (num_steps==steps)
            putmarker!(r)
        end
    end
    return(num_steps)
end

movingback!(r::Robot, side::HorizonSide, num_steps::Int) = for i in 1:num_steps
    move!(r,side)
end