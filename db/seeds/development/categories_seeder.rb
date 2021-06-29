# このシーダーは、先にmajor_categories_seeder.rbで親カテゴリを作成しておかないと動作しない
major_category_names_and_ids = MajorCategory.major_category_name_and_id

major_category_names = ["本", "コンピュータ", "ディスプレイ"]
book_categories = ["ビジネス", "文学・評論", "人文・思想", "スポーツ",
                    "コンピュータ・IT", "資格・検定・就職", "絵本・児童書", "写真集",
                    "ゲーム攻略本", "雑誌", "アート・デザイン", "ノンフィクション"]
computer_categories = ["ノートPC", "デスクトップPC", "タブレット"]
display_categories = ["19~20インチ", "デスクトップPC", "タブレット"]

major_category_names_and_ids.each do |major_category_name,major_category_id|
  if major_category_name == "本"


    book_categories.each do |book_category|
      Category.create(
        name: book_category,
        description: book_category,
        major_category_name: major_category_name,
        major_category_id: major_category_id
      )
    end
  elsif major_category_name == "コンピュータ"
    computer_categories.each do |computer_category|
      Category.create(
        name: computer_category,
        description: computer_category,
        major_category_name: major_category_name,
        major_category_id: major_category_id
      )
    end
  elsif major_category_name == "ディスプレイ"
    display_categories.each do |display_category|
      Category.create(
        name: display_category,
        description: display_category,
        major_category_name: major_category_name,
        major_category_id: major_category_id
      )
    end
  end
end