function [x,y] = circlefunction9(bs,s)
% Create a unit circle centered at (0,0) using four segments.
NumElecs=9;
switch nargin
    case 0
        x = NumElecs;
        return
    case 1
        
        A=zeros(4,NumElecs);
        for j=1:NumElecs
            A(1,j)=(j-1.5)*2*pi/NumElecs;
            A(2,j)=(j-0.5)*2*pi/NumElecs;
            A(3,j)=1;
            A(4,j)=0;
        end
        x = A(:,bs); % return requested columns
        return
    case 2
        x = cos(s);
        y = sin(s);
end
