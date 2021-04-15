

def substrings(input, dict)
    out_hash = Hash.new(0)    
    clean_string = input.downcase.split(" ")

    dict.each do |word|
        clean_string.each do |sep_input|
            match = sep_input.slice(word)
            if (match != nil)
                out_hash[match] += 1
            end
        end
    end

    return out_hash;
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings("Howdy partner, sit down! How's it going?", dictionary)



