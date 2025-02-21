% https://en.wikipedia.org/wiki/Walsh_function
% https://it.wikipedia.org/wiki/Matrice_di_Walsh

function UW = generateWalshBasis(N)
    if mod(log2(N), 1) ~= 0
        error('N must be a power of 2');
    end

    % Hadamard matrix for N = 2
    UW = [1 1; 1 -1];
    
    % iterate 
    while size(UW, 1) < N
        % duplicate the current matrix
        UW = [UW, UW; UW, -UW];
    end
    
    % normalization
    UW = UW / sqrt(N);
end
