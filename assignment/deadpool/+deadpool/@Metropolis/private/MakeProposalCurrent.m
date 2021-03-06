function MakeProposalCurrent(obj)
%MakeProposalCurrent - makes proposed pouint current point

    % If the proposed value was accepted keep as current point
    if obj.Accept;
        obj.PointX = obj.PointX;
        obj.PointY = obj.PointY;
    % If proposed point was not accepted return to previous saved value
    else 
        obj.PointX = obj.XHistory(: , obj.StepCount);
        obj.PointY = obj.YHistory(obj.StepCount);
    end
end