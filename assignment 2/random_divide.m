function r_cell = random_divide(A,k)
    r_cell = cell(k,1);
    nRows = size(A,1);
    randRows = randperm(nRows);
    Perm = ones(size(A,1),size(A,2));
    for i = 1:nRows
        Perm(i,:) = A(randRows(i),:);
    end
    n = 0;
    s = ceil(nRows/k);
    for i = 1:k
        begin_point = n+1;
        end_point = n+s;
        if(end_point > nRows)
            end_point = nRows;
        end
        r_cell{i} = Perm((begin_point:end_point),:);
        n = end_point;
    end
    clearvars nRows randRows Perm n s begin_point end_point
end