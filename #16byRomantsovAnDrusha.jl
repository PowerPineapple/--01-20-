function KD!(r::Robot)
    Map=move_to_the_corner!(r)
    Fuller!(r)
    comeback!(r,Map)    
end


function Fuller!(r::Robot)
    flag=0
    putmarkers!(r,HorizonSide(0))
    moving!(r,HorizonSide(2))
    if (isborder(r,HorizonSide(1))==0)
        move!(r,HorizonSide(1))
    end
    while (flag==0)
        putmarkers_new!(r,HorizonSide(0))
        move_by_markers_2!(r,HorizonSide(2))
        if (isborder(r,HorizonSide(1))==0)
            move!(r,HorizonSide(1))
        else
            putmarker!(r)
            putmarkers_new!(r,HorizonSide(3))
            flag=1
        end
    end
end

function putmarkers_new!(r::Robot,side::HorizonSide)
    flag=0
    while flag!=2
        if isborder(r,side)==false
            move!(r,side)
        else
            flag=avoider!(r,side)
        end
        putmarker!(r)
    end
end

function move_by_markers_2!(r::Robot,side::HorizonSide)
    flag=0
    while (ismarker(r)==true && flag!=2)
        if isborder(r,side)==true
            flag=avoider!(r,side)
        else
            move!(r,side)
        end
    end
end

function avoider!(r::Robot,side::HorizonSide)
    steps=0
    flag=0
    while (flag==0)
        if isborder(r,inverse_2(side))==false && isborder(r,side)==true
            move!(r,inverse_2(side))
            steps=steps+1
            if isborder(r,side)==false
                move!(r,side)
                if isborder(r,inverse_3(side))==false
                    move!(r,inverse_3(side))
                    steps=steps-1
                    flag=1
                end
            end
        end
        if isborder(r,inverse_3(side))==true && isborder(r,side)==false
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
    return(flag)
end

movingback!(r::Robot, side::HorizonSide, num_steps::Int) = for i in 1:num_steps
    move!(r,side)
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

inverse_2(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))

inverse_3(side::HorizonSide) = HorizonSide(mod(Int(side)+3, 4))



function move_to_the_corner!(r::Robot)
    Way=[]
    while (isborder(r, HorizonSide(3))==false) || (isborder(r,HorizonSide(2))==false)
        push!(Way,moving!(r,HorizonSide(3)))
        push!(Way,moving!(r,HorizonSide(2)))
    end
    return(Way)
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

putmarkers!(r::Robot,side::HorizonSide) = while isborder(r,side)==false 
    move!(r,side)
    putmarker!(r)
end