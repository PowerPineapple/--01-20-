function Sherlock!(r::Robot)
    Num = 1
    Gonshik!(r,Num)
end

Gonshik!(r::Robot, step::Int) = while (isborder(r,HorizonSide(0))==true)
    direction=mod(step,2)*2+1
    movingback!(r,HorizonSide(direction),step)
    step=step+1
end

movingback!(r::Robot, side::HorizonSide, num_steps::Int) = for i in 1:num_steps
    move!(r,side)
end