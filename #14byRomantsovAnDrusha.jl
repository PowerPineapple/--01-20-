function mark_kross_new!(r::Robot)
    for side in (HorizonSide(i) for i=0:3)
        putmarkers_new!(r,side)
        move_by_markers_new!(r,inverse(side))
    end
    putmarker!(r)
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

function move_by_markers_new!(r::Robot,side::HorizonSide)
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