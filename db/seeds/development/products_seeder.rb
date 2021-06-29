product_ids = [*1..30]
category_ids = [*1..18,*1..12]
array_number = 0

product_ids.each do
  product_name = Faker::Music::RockBand.name
  Product.create(
    name: product_name,
    description: product_name,
    price: product_ids[array_number],
    category_id: category_ids[array_number],
    recommended_flag: false
  )
  array_number += 1
end