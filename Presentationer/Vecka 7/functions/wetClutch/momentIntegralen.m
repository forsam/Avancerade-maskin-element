function summan = momentIntegralen( omegaEngine, omegaDriveshaft )
    
    ri = 0.065;
    ry = 0.085;
    
    k = 10*2*pi;
    
    sum = 0;
    
    R = linspace(ri,ry,100);
    
    for i = 2:length(R)
       
        v = (omegaEngine - omegaDriveshaft).*R(i);
        inner = R(i).^2.*v.*frictionCoefficient(v);
        dr = R(i)-R(i-1);
        sum = sum + inner*dr;
    end
    
    summan = sum;

end

