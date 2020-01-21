require_relative 'models/property_tracker.rb'
require 'pry'

Property.delete_all()

house1 = Property.new({
  'address' => '82 Barrland Street',
  'value' => 200000,
  'number_of_bedrooms' => 2,
  'year' => 1995,
  'buy_let_status' => 'let',
  'square_footage' => 120,
  'build' => 'flat'
})

house2 = Property.new({
  'address' => '120 Union Street',
  'value' => 280000,
  'number_of_bedrooms' => 3,
  'year' => 2000,
  'buy_let_status' => 'buy',
  'square_footage' => 200,
  'build' => 'house'
})

house1.save()
house2.save()




binding.pry
nil
