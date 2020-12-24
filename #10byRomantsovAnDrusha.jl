function meridian!(r::Robot)
    summa=0
    kolvo=0
    flag=0
    side=2
    while flag==0
        side=mod((side + 2),4)
        summa1,kolvo1 = elevator_temp(r,HorizonSide(side))
        summa = summa + summa1
        kolvo = kolvo + kolvo1
        if isborder(r,HorizonSide(3)) == 0
            move!(r,HorizonSide(3))
        else
            flag=1
        end
    end
    return(summa/kolvo)
end

function elevator_temp(r::Robot, way::HorizonSide)
    flag = true
    temp_vert=0
    kolvo_vert = 0
    while (flag)
        if ismarker(r)
            temp_vert = temp_vert + temperature(r)
            kolvo_vert = kolvo_vert + 1
        end
        if isborder(r,way)
            flag = false
        else
            move!(r,way)
        end
    end
    return(temp_vert, kolvo_vert)
end