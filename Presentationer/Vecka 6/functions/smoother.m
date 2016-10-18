function array = smoother( array, smothIndex)
    ending = length(array) - smothIndex;
    for i = 1:ending
        span = i:(smothIndex+i);
        array(i) = sum(array(span))/smothIndex;
    end
    array((ending+1):end) = array(ending);
end

