prices = [17,3,6,9,15,8,6,1,10]
def stock_picker(prices)       
    high = [prices.last, 0]
    low = [prices[0], 0]
    prices.each_with_index do |val,ind|         
        
        if val > high[0] && high[1] < low[1]
            high[0] = val
            high[1] = ind            
        end
        
        if val < low[0] && !(high[1] > low[1])            
            low[0] = val
            low[1] = ind
        end
        
    end
    return [low, high]
end

result = stock_picker([17,3,6,9,15,8,6,1,10])
puts "Buy on day #{result[0][1]} and sell on day #{result[1][1]} for a profit of $#{result[1][0]} - $#{result[0][0]} = $#{result[1][0] - result[0][0]}"