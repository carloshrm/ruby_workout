
def cypher(string, factor)   
    string.each_char.reduce("") do |cyphered_output, char|         
        if is_in_range(char)
            after_shift = (char.ord + factor)
            is_in_range(after_shift) ? cyphered_output += after_shift.chr : cyphered_output += (after_shift-26).chr
        else        
            cyphered_output += char                 
        end
    end
end

def is_in_range(char)
    unless char.is_a? Numeric
        char = char.ord
    end
    (65..90).include?(char) || (97..122).include?(char)
end

puts "Type in some text to be cyphered:"
input_string = gets.chomp
if input_string.empty? || input_string == " "
    puts "No text was entered."
    return;
end
puts "Type in a number between 1 and 25 for the factor: "
input_factor = gets.chomp.to_i
if input_factor < 1 || input_factor > 25
    puts "Not a valid number."
    return;    
end
puts "   Input text: #{input_string}"
puts "Cyphered text: #{cypher(input_string, input_factor)}"
