function eta = electricEffiency( torque )
    if torque < 180 && torque > 0
        eta = 90.*tanh(0.2.*torque)- 0.5.*torque;
        eta = eta./100;
    else
        eta = 0.001;
    end
end

