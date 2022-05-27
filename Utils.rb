#Created 5/26/2022 by Max Zahner

module Utils
    
    #Created 5/23/2022 by Max Zahner
    #Modified 5/25/2022 by Max Zahner
    def is_set?(card1, card2, card3)
        #is___Set is true iff all the attributes are all the same all or different
        is_shade_set = same_or_different? card1.shade card2.shade card3.shade
        is_shape_set = same_or_different? card1.shape card2.shape card3.shape
        is_color_set = same_or_different? card1.color card2.color card3.color
        is_number_set = same_or_different? card1.number card2.number card3.number
        #evaluating whether the set itself is a set. It must be a ShapeSet, ShadeSet, ColorSet and NumberSet to be a set
        return is_shade_set && is_shape_set && is_number_set && is_color_set
    end

    #Created 5/25/2022 by Max Zahner
    #returns whether the attributes are all the same or all different
    def same_or_different?(condition1, condition2, condition3)
        return (conditon1 == conditon2 && conditon2 == conditon3) || 
        (conditon1 != conditon2 && conditon2 != conditon3 && conditon1 != conditon3)
    end
end