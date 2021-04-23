# frozen_string_literal: true

def bubble_sort(numbers, not_sorted: true)
  while not_sorted
    not_sorted = false
    numbers.each_with_index do |_v, i|
      next if i.zero?

      if numbers[i - 1] > numbers[i]
        numbers[i - 1], numbers[i] = numbers[i], numbers[i - 1]
        not_sorted = true
      end
    end
  end
  numbers
end

numbers = [4, 3, 78, 2, 0, 2, -1, 32, 5, 6, -2]
puts bubble_sort(numbers)
