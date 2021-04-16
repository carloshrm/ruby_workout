def bubble_sort(numbers, notSorted = true)   
    while notSorted        
        notSorted = false        
        numbers.each_with_index do |v, i|
            next if i == 0
            if numbers[i-1] > numbers[i]
                numbers[i-1],numbers[i] = numbers[i],numbers[i-1]
                notSorted = true
            end            
        end
    end    
    return numbers    
end

numbers = [4,3,78,2,0,2,-1,32,5,6,-2]
puts bubble_sort(numbers)
