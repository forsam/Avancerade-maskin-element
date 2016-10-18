function C = frictionCoefficient( slidingSpeed )
    
    k = 0.01;
    C = abs(0.07 + 0.05.*tanh(slidingSpeed./2) + k.*slidingSpeed);

end

