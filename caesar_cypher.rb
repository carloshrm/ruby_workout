
def cypher(string, factor)    
    # take each character in the string, use the reduce accumulator to build a new string
    # send character to be checked, if it's not a letter, add it to the output as-is ( for spaces, punctuation, numbers, etc... )
    # if it is a character, get the char number(.ord) -> shift it by factor -> check again to see if it didn't go beyond Z
    # take the shifted and checked value -> convert it from a number to a char(.chr)
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
    #make sure the input is a number for the range
    #checks if the input is either "A" to "Z", or "a" to "z". 
    unless char.is_a? Numeric
        char = char.ord
    end
    (65..90).include?(char) || (97..122).include?(char)
end

puts "Type in some text to be cyphered:"
input_string = gets.chomp
puts "Type in a number between 1 and 25 for the factor: "
input_factor = gets.chomp.to_i
if input_factor < 1 || input_factor > 25
    puts "Not a valid number."
    return;    
end
puts "   Input text: #{input_string}"
puts "Cyphered text: #{cypher(input_string, input_factor)}"
