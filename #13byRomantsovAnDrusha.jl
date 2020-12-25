function mark_kross_2!(r::Robot)
    for side in (HorizonSide(i) for i=0:3)
        putmarkers_2!(r,side)
        move_by_markers_2!(r,inverse(side))
    end
    putmarker!(r)
end

putmarkers_2!(r::Robot,side::HorizonSide) = while isborder(r,side)==false && isborder(r,inverse_2(side))==false
    move!(r,side)
    move!(r,inverse_2(side))
    putmarker!(r)
end

move_by_markers_2!(r::Robot,side::HorizonSide) = while (ismarker(r)==true) 
    move!(r,side)
    move!(r,inverse_2(side))
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

inverse_2(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))