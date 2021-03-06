require 'set'

cards = []

ARGF.each_with_index do |line, idx|
  next if idx == 0
  cards << line
end

def normalize_card(card)
  card = card.split(" ")
  lhs = card[0]
  rhs = card[1]
  return "#{to_color(lhs)}#{to_count(rhs)}#{to_case(rhs)}#{to_sym(rhs)}"
end

def to_color(lhs)
  if lhs == 'blue'
    return 'b'
  end
  if lhs == 'green'
    return 'g'
  end
  if lhs == 'yellow'
    return 'y'
  end
end

def to_count(rhs)
  rhs.length
end

def to_case(rhs)
  if rhs.include?('$') || rhs.include?('@') || rhs.include?('#')
    return 'S'
  end
  if rhs.include?('s') || rhs.include?('a') || rhs.include?('h')
    return 'L'
  end
  if rhs.include?('S') || rhs.include?('A') || rhs.include?('H')
    return 'U'
  end
end

def to_sym(rhs)
  if rhs.include?('$') || rhs.include?('s') || rhs.include?('S')
    return 's'
  end
  if rhs.include?('@') || rhs.include?('a') || rhs.include?('A')
    return 'a'
  end
  if rhs.include?('#') || rhs.include?('h') || rhs.include?('H')
    return 'h'
  end
end

def valid_set?(combo1, combo2, combo3)
  for i in 0..3 do
    return false if Set.new([combo1[i],combo2[i],combo3[i]]).length == 2
  end
  return true
end

normalized_cards = cards.map { |card| normalize_card(card) }
sets = normalized_cards.combination(3).to_a.select do |combination|
  valid_set?(combination[0], combination[1], combination[2])
end

sets.each do |card|
  puts "#{card[0]} #{card[1]} #{card[2]}"
end
