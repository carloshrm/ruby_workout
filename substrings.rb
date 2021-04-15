

def substrings(input, dict)
    out_hash = Hash.new(0)    
    clean_string = input.gsub(/[[:punct:]]/, "").downcase.split(" ")

    clean_string.each do |word|        
        dict.each do |sep_input|              
            if word.include?(sep_input)   
                match = word.slice(sep_input)
                out_hash[match.to_sym] += 1           
            end
        end
    end

    return out_hash;
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings("Howdy partner, sit down! How's it going?", dictionary)


