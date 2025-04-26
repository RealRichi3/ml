function classID = CollapseBinaryVectorToClass(classVec)
% generate binary output vector by choosing largest vector element

% data point coint
len= size(classVec,2);

% number of network outputs
width= size(classVec,1);

% if multi output pick biggest
if(width > 1)
    classID=[];
    for idx=1:len
        vec = classVec(:,idx);
        [Y,I] = nanmax(vec);
        classID(idx) = I-1;
    end
    
% if single outpout then threshold
else
    classID = zeros(1, len);
    fidx = find(classVec > 0.5);
    classID(fidx) = 1;
end