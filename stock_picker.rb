
def stock_picker(prices)       
    high = prices[0]  
    low = prices[0]
    prices.each do |v|
        high = v if v > high
        low = v if v < low
    end
    
    return [prices.find_index(low),prices.find_index(high)]
end

result = stock_picker([2,17,3,6,0,9,15,8,6,1])
puts "Buy on day #{result[0]+1}, sell on day #{result[1]+1}"