# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
tokyo_wards = TokyoWard.create([
  {name: '足立区', latitude: 35.77538431785286, longitude: 139.80454767800697},
  {name: '荒川区', latitude: 35.736163856807295, longitude: 139.7831498387147},
  {name: '板橋区', latitude: 35.75135273614596, longitude: 139.70950282522446},
  {name: '江戸川区', latitude: 35.70750090912388, longitude: 139.86855568658729},
  {name: '大田区', latitude: 35.56219140908899, longitude: 139.71620955580795},
  {name: '葛飾区', latitude: 35.74439528529307, longitude: 139.8473347866115},
  {name: '北区', latitude: 35.75368541862942, longitude: 139.73405303661772},
  {name: '江東区', latitude: 35.673725163520274, longitude: 139.81726742519734},
  {name: '品川区', latitude: 35.60992927010143, longitude: 139.7301498944717},
  {name: '渋谷区', latitude: 35.664346228139536, longitude: 139.69786958655894},
  {name: '新宿区', latitude: 35.69467288321413, longitude: 139.70334292521122},
  {name: '杉並区', latitude: 35.700211730238244, longitude: 139.63645777124063},
  {name: '墨田区', latitude: 35.711403383382425, longitude: 139.80174037124803},
  {name: '世田谷区', latitude: 35.64724297010918, longitude: 139.65314667915436},
  {name: '台東区', latitude: 35.71333411181675, longitude: 139.77997784056544},
  {name: '千代田区', latitude: 35.694844988497195, longitude: 139.7534894558951},
  {name: '中央区', latitude: 35.67139946053185, longitude: 139.77195072519592},
  {name: '豊島区', latitude: 35.72678493053872, longitude: 139.71664944057437},
  {name: '中野区', latitude: 35.707889518755636, longitude: 139.6636047791943},
  {name: '練馬区', latitude: 35.73641119409678, longitude: 139.65181875592262},
  {name: '文京区', latitude: 35.70900974056391, longitude: 139.75190836385295},
  {name: '港区', latitude: 35.65865030623709, longitude: 139.75135129450376},
  {name: '目黒区', latitude: 35.64219699407184, longitude: 139.69827978654425},
])