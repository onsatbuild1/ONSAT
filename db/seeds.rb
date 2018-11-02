# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)





scales = [{:level=> 0, :score => 0.5, :description => 'BLevel 0',:category =>'B'},
        {:level=> 1, :score => 0.5, :description => 'BLevel 1',:category =>'B'},
        {:level=> 2, :score => 0.5, :description => 'BLevel 2',:category =>'B'},
        {:level=> 3, :score => 0.5, :description => 'BLevel 3',:category =>'B'},
        {:level=> 4, :score => 0.5, :description => 'BLevel 4',:category =>'B'},
        {:level=> 5, :score => 0.5, :description => 'BLevel 5',:category =>'B'},
        {:level=> 6, :score => 0.5, :description => 'BLevel 6',:category =>'B'},
        {:level=> 0, :score => 0.5, :description => 'SLevel 0',:category =>'S'},
        {:level=> 1, :score => 0.5, :description => 'SLevel 1',:category =>'S'},
        {:level=> 2, :score => 0.5, :description => 'SLevel 2',:category =>'S'},
        {:level=> 3, :score => 0.5, :description => 'SLevel 3',:category =>'S'},
        {:level=> 4, :score => 0.5, :description => 'SLevel 4',:category =>'S'},
        {:level=> 5, :score => 0.5, :description => 'SLevel 5',:category =>'S'},
        {:level=> 6, :score => 0.5, :description => 'SLevel 6',:category =>'S'},
  	 ]

scales.each do |scale|
  Scale.create!(scale)
end

csv_file = File.read('db/BusinessSubcategoryWeights.csv')
csv=CSV.parse(csv_file,headers: true,skip_blanks: true).reject { |row| row.to_hash.values.all?(&:nil?) }
csv.each do |row|
    subcategory={:subcategory_index => row['index'], 
                :weight => row['Default Category Weight (Equal Weight)'], 
                :description => row['SERVICE PROVIDER BUSINESS INFORMATION'], 
                :category => 'B'}
    #print(row['index'])
    Subcategory.create!(subcategory)
end

csv_file = File.read('db/BusinessQuestionWeights.csv')
csv=CSV.parse(csv_file,headers: true).reject { |row| row.to_hash.values.all?(&:nil?) }
subcategory_index_fornow='A';
csv.each do |row|
  if(row['User Defined Weights  (Sum = 1.00)']=='0')
    subcategory_index_fornow=row['index']
  else
    question={:keyword => row['SERVICE PROVIDER BUSINESS INFORMATION'], 
              :index => row['index'], 
              :weight => row['Default Category Weight (Equal Weight)'], 
              :description => row['SERVICE PROVIDER BUSINESS INFORMATION'],
              :category => 'B',
              :subcategory_id => Subcategory.find_by(subcategory_index: subcategory_index_fornow, category:'B' ).id}
    Question.create!(question)
  end
end


csv_file = File.read('db/SecuritySubcategoryWeights.csv')
csv=CSV.parse(csv_file,headers: true,skip_blanks: true).reject { |row| row.to_hash.values.all?(&:nil?) }
csv.each do |row|
    subcategory={:subcategory_index => row['Unique  Ref ID'], 
                :weight => row['Default'], 
                :description => row['Category'], 
                :category => 'S'}
    #print(row['index'])
    Subcategory.create!(subcategory)
end

csv_file = File.read('db/SecurityQuestionWeights.csv')
csv=CSV.parse(csv_file,headers: true,:encoding => 'ISO-8859-1').reject { |row| row.to_hash.values.all?(&:nil?) }
subcategory_index_fornow='A';
csv.each do |row|
  if(row['Unique  Ref ID']!=nil)
    if(!(row['Unique  Ref ID']=~/-/))
      subcategory_index_fornow=row['Unique  Ref ID']
      #print(row)
    else
      question={:keyword => row['Category / Question'], 
              :index => row['Category / Question ID'], 
              :weight => row['Default'], 
              :description => row['Category / Question'],
              :category => 'S',
              :subcategory_id => Subcategory.find_by(subcategory_index: subcategory_index_fornow, category:'S' ).id}
      Question.create!(question)
    end
  end
end
#