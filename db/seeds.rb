# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds/categories.rb

categories_data = {
  "00": "조직물류 [고상]",
  "01": "조직물류 [액상]",
  "10": "태반(재활용) [고상]",
  "30": "일반의료 [고상]",
  "31": "일반의료 [액상]",
  "40": "손상성 [고상]",
  "50": "병리계 [고상]",
  "51": "병리계 [액상]",
  "60": "생물화학 [고상]",
  "61": "생물화학 [액상]",
  "70": "혈액오염 [고상]",
  "71": "혈액오염 [액상]",
  "80": "격리의료 [고상]",
  "81": "격리의료 [액상]",
  "90": "메르스 [고상]",
  "91": "메르스 [액상]"
}

categories_data.each do |code, name|
  Category.create(code: code, name: name)
end

elements_data = [
  { w: 3.8, f: 93.2, a: 3, c: 66.99, h: 7.74, o: 17.63, n: 0.11, s: 0.09, cl: 0, season: 'autumn', hhv_temp: nil, lhv_temp: nil, category_id: 4 },
  { w: 2.4, f: 65.6, a: 32, c: 47.64, h: 5.49, o: 12.41, n: 0.08, s: 0.08, cl: 0, season: 'spring', hhv_temp: nil, lhv_temp: nil, category_id: 9 },
  { w: 1.8, f: 67.6, a: 30.6, c: 50.32, h: 5.83, o: 11.39, n: 0.05, s: 0.03, cl: 0, season: 'spring', hhv_temp: nil, lhv_temp: nil, category_id: 6 },
  { w: 2, f: 97, a: 1, c: 77.34, h: 9.19, o: 10.4, n: 0.06, s: 0.06, cl: 0, season: 'spring', hhv_temp: nil, lhv_temp: nil, category_id: 1 },
  { w: 2.6, f: 90.7, a: 6.7, c: 69.33, h: 8.21, o: 13.07, n: 0.07, s: 0.06, cl: 0, season: 'spring', hhv_temp: nil, lhv_temp: nil, category_id: 7 },
  { w: 1.7, f: 96.1, a: 2.2, c: 71.3, h: 7.86, o: 15.69, n: 0.16, s: 0.22, cl: 0, season: 'spring', hhv_temp: nil, lhv_temp: nil, category_id: 11 },
  { w: 4.8, f: 92.2, a: 3, c: 66.42, h: 7.96, o: 17.6, n: 0.13, s: 0.1, cl: 0, season: 'spring', hhv_temp: nil, lhv_temp: nil, category_id: 13 }
]

elements_data.each do |data|
  Element.create(data)
end

cal_marks_data = [
  { low: 20000, middle: 40000 }
]

cal_marks_data.each do |data|
  CalMark.create(data)
end

fomulas_data = [
  { hhv_formula: "(8100*c/100)+(34000*((h/100)-((n/100)/8)))+(2500*(s/100))", lhv_formula: "((8100*c/100)+(34000*((h/100)-((n/100)/8)))+(2500*(s/100)))-600*((9*(h/100))+(w/100))" }
]

fomulas_data.each do |data|
  Formula.create(data)
end