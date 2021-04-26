function [c, ceq, gradc, gradceq] = image_nlcon( image, I, g )
    c = []; gradc = [];
    ceq = [];
    
    if nargout == 1
        ceq = my_intensity_obj( image, g ) - I;
    elseif nargout >= 2
        [func, gradceq] = my_intensity_obj( image, g );
        ceq = func - I; 
    end
end