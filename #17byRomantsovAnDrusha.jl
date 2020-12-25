function Heaven_2!(r::Robot)
    Map=move_to_the_corner_SW!(r)
    Stair_Builder_2!(r)
    comeback_SW!(r,Map)    
end


function Stair_Builder_2!(r)
    putmarkers!(r,HorizonSide(3))
    Wide=moving!(r,HorizonSide(1))
    Middle_Stairs(r,Wide)
    putmarker!(r)
    moving!(r,HorizonSide(2))
end

Middle_Stairs(r::Robot, Wide::Int) = while (isborder(r,HorizonSide(0))==false) && (Wide>0)
    putmarker!(r)
    move!(r,HorizonSide(0))
    putmarkers_new!(r,HorizonSide(3),Wide)
    move_to_the_corner_SW!(r)
    move_by_markers!(r,HorizonSide(0))
    Wide=Wide-1
end

function putmarkers_new!(r::Robot,side::HorizonSide,Number::Int)
    flag=0
    while (flag!=2 && Number>0)
        if isborder(r,side)==false
            Number=Number-1
            move!(r,side)
        else
            Number,flag=avoider_2!(r,side,Number)
        end
        if Number>0
            putmarker!(r)
        end
    end
end

move_by_markers!(r::Robot,side::HorizonSide) = while ismarker(r)==true 
    move!(r,side) 
end

function avoider_2!(r::Robot,side::HorizonSide,Wide::Int)
    steps=0
    flag=0
    while (flag==0) && (Wide>0)
        if isborder(r,inverse_2(side))==false && isborder(r,side)==true
            move!(r,inverse_2(side))
            steps=steps+1
            if isborder(r,side)==false
                move!(r,side)
                Wide=Wide-1
                if isborder(r,inverse_3(side))==false
                    move!(r,inverse_3(side))
                    steps=steps-1
                    flag=1
                end
            end
        end
        if isborder(r,inverse_3(side))==true && isborder(r,side)==false
            Wide=Wide-1
            move!(r,side)
            if isborder(r,inverse_3(side))==false
                move!(r,inverse_3(side))
                steps=steps-1
                flag=1
            end
        end
        if isborder(r,side)==true && isborder(r,inverse_2(side))==true
            flag=2
        end
    end
    movingback!(r,inverse_3(side),steps)
    return(Wide,flag)
end

movingback!(r::Robot, side::HorizonSide, num_steps::Int) = for i in 1:num_steps
    move!(r,side)
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

inverse_2(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))

inverse_3(side::HorizonSide) = HorizonSide(mod(Int(side)+3, 4))



function move_to_the_corner_SW!(r::Robot)
    Way=[]
    while (isborder(r, HorizonSide(1))==false) || (isborder(r,HorizonSide(2))==false)
        push!(Way,moving!(r,HorizonSide(1)))
        push!(Way,moving!(r,HorizonSide(2)))
    end
    return(Way)
end

comeback_SW!(r::Robot,Wayback::Any) = while length(Wayback)>0
    movingback!(r,HorizonSide(0),Wayback[end])
    pop!(Wayback)
    movingback!(r,HorizonSide(3),Wayback[end])
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

putmarkers!(r::Robot,side::HorizonSide) = while isborder(r,side)==false 
    move!(r,side)
    putmarker!(r)
end