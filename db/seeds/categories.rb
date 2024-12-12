# frozen_string_literal: true

CATEGORIES = [
  'Личные вещи',
  'Транспорт',
  'Работа',
  'Для дома и дачи',
  'Недвижимость',
  'Хобби и отдых',
  'Электроника',
  'Животные'
].freeze

CATEGORIES.each do |category_name|
  Category.find_or_create_by!(name: category_name)
end
