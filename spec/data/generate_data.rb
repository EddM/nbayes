require "json"

def add_feature(tuple, feature)
  tuple[1] << feature
end

# We have 500 bananas...
bananas = []
500.times { bananas << [:banana, []] }
# ...400 of them are long...
bananas.sample(400).each { |banana| add_feature(banana, :long) }
# ...350 of them are sweet...
bananas.sample(350).each { |banana| add_feature(banana, :sweet) }
# ...and all of them are long.
bananas.each { |banana| add_feature(banana, :yellow) }

# We have 300 oranges
oranges = []
300.times { oranges << [:orange, []] }

# ...150 of them are sweet...
oranges.sample(150).each { |orange| add_feature(orange, :sweet) }
# ...and all of them are yellow (?).
oranges.each { |orange| add_feature(orange, :yellow) }

# We have 200 other fruits...
others = []
200.times { others << [:other, []] }

# ...100 of them are long...
others.sample(100).each { |other| add_feature(other, :long) }
# ...150 of them are sweet...
others.sample(150).each { |other| add_feature(other, :sweet) }
# ...and 50 of them are yellow.
others.sample(50).each { |other| add_feature(other, :yellow) }

# Now lets save that fruit salad to a file, shall we?
fruits = bananas + oranges + others
file_path = File.join(File.dirname(__FILE__), "fruits.json")
file = File.open(file_path, "w")
file.write(fruits.to_json)
file.close
