def print_with_line(message)
  puts message
  puts "=" * message.length 
end

def count_bits(n)
  count = 0
  1000.downto(0) do |i|
    if n >= 2**i
      count += n/2**i
      n -= 2**i
    end
  end
  return count
end

def best_count_bits(n)
  n.to_s(2).count("1")
end

def duplicate_count(text)
  unique = []
  duplicate = []
  count = 0
  for idx in 0...text.length
    char = text[idx].downcase
    if unique.include?(char) && !duplicate.include?(char)
      count += 1
      duplicate << text[idx]
    else 
      unique << text[idx]
    end
  end
  return count
end

def best_duplicate_count(text)
  ("a".."z").count { |c| text.downcase.count(c) > 1}
end

def find_it(seq)
  unique = seq.uniq
  for num in unique
    return num if seq.count(num) % 2 == 1
  end
end

def best_find_it(seq)
  seq.uniq.each do |num|
    return num if seq.count(num).odd?
  end
end

def order(words)
  return "" if words.length <= 0 
  words = words.split(" ")
  result = ""
  (1..9).each {|i| (0...words.length).each {|idx| result +=  words[idx].include?(i.to_s) ? words[idx] + " " : ""}}
  return result.rstrip
end

def best_order(words)
  words.split.sort_by{ |w| w.chars.min }.join(" ")
end

def basic_tribonacci(signature, n)
  return Array.new if n == 0
  return signature.first(n) if signature.length > n
  begin 
    signature.push(signature.last(3).sum)
  end until signature.length == n
  return signature
end

def tribonacci(signature, n)
  begin 
    signature.push(signature.last(3).sum)
  end until signature.length == n
  return signature.slice(0, n)
end

def best_tribonacci(signature, n)
  for i in 3...n
    signature[i] = signature[i-1] + signature[i-2] + signature[i-3]
  end
  return signature.slice(0, n)
end

def first_non_repeating_letter(s)
  s.chars { |c| return c if s.downcase.count(c.downcase) == 1 }
  return ""
end

def best_first_non_repeating_letter(s)
  s.chars.find { |c| return c if s.downcase.count(c.downcase) == 1 } || ""
end

# print_with_line("Count bits")
# puts count_bits(1234)

# print_with_line("\nDuplicate count")
# puts best_count_bits 1234
# puts best_duplicate_count("homwEwW")

# print_with_line("\nFind it")
# puts find_it([0, 1, 2, 3, 1, 2, 3, 4])
# puts best_find_it([0, 1, 2, 3, 1, 2, 3, 4])

# print_with_line("\nOrder")
# puts order("is2 Thi1s T4est 3a")
# puts best_order("is2 Thi1s T4est 3a")

# print_with_line("\nTribonacci")
# puts tribonacci([1,1,1], 10)
# puts best_tribonacci([1,1,1], 2)

# print_with_line("\nFirst non-repeating string")
# puts first_non_repeating_letter("sTress")
# puts first_non_repeating_letter("abba")
# puts best_first_non_repeating_letter("sTress")
# puts best_first_non_repeating_letter("abba")