function trans = Trans(A)
    dim = size(A);
    row = dim(2);
    col = dim(1);
    for i = 1:row
        for j = 1:col
            trans(i,j) = A(j,i);
        end
    end
end