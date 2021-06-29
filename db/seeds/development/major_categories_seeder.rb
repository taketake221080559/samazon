major_category_names = ["本", "コンピュータ", "ディスプレイ"]

major_category_names.each do |major_category_name|
  MajorCategory.create(
    name: major_category_name,
    description: major_category_name,
  )
end