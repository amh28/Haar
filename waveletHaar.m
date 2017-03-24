function [wavelet, rept] = waveletHaar(imagen, depth)

    [m, n, o] = size(imagen);

    if o > 1
        img = rgb2gray(imagen);
    else
        img = imagen;
    end
    
    if depth == 0 || mod(m,2) == 1 || mod(n,2) == 1
        wavelet = img;
        rept = 0;
        return
    else
        wavelet = zeros(m,n);
        tmp = zeros(m,n);
        
        for i = 1:m
            for j = 1:2:n - 1
                c = ceil(j/2);
                tmp(i, c) = double(img(i, j)) + double(img(i, j+1));
                tmp(i, c + n/2) = double(img(i, j)) - double(img(i, j+1));                
            end
        end
        
        for i = 1:n
            for j = 1:2:m - 1
                c = ceil(j/2);
                wavelet(c, i) = tmp(j, i) + tmp(j+1, i);
                wavelet(c+ n/2, i) = tmp(j, i) - tmp(j+1, i);
            end
        end
        
        [wavelet(1:m/2, 1:n/2), rept] = waveletHaar(wavelet(1:m/2,1:n/2), depth - 1);
        rept = rept + 1;
    end
    
end