function original = iwaveletHaar(imagen, depth)

    [m, n] = size(imagen);

    img = imagen;
    
    if depth == 0 || mod(m,2) == 1 || mod(n,2) == 1
        original = img;
        return
    else
        img(1:m/2, 1:n/2) = iwaveletHaar(img(1:m/2,1:n/2), depth - 1);
        
        original = zeros(m,n);
        tmp = zeros(m,n);
        
        for i = 1:n
            for j = 1:m/2
                tmp(2*j - 1, i) = (img(j, i) + img(j + m/2, i))/2;
                tmp(2*j, i) = (img(j, i) - img(j + m/2, i))/2;
            end
        end
        
        for i = 1:m
            for j = 1:n/2
                original(i, 2*j - 1) = (tmp(i, j) + tmp(i, j + m/2))/2;
                original(i, 2*j) = (tmp(i, j) - tmp(i, j + m/2))/2;
            end
        end
    end
    
end
