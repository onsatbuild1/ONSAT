# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


companies=[{:name => 'Good Company', :company_score => 0, :description => 'It\'s Good Company'},
           {:name => 'Bad Company', :company_score => 0, :description => 'It\'s Bad Company'},
           {:name => 'Ugly Company', :company_score => 0, :description => 'It\'s Ugly Company'},
           {:name => 'sub Good Company1', :company_score => 0, :description => 'It\'s Good Company'},
           {:name => 'sub Good Company2', :company_score => 0, :description => 'It\'s Good Company'},
           {:name => 'sub Bad Company1', :company_score => 0, :description => 'It\'s Bad Company'},
           {:name => 'sub Bad Company2', :company_score => 0, :description => 'It\'s Bad Company'},
           {:name => 'sub Ugly Company', :company_score => 0, :description => 'It\'s Ugly Company'},
           ]
        
companies.each do |company|
  Company.create!(company)
end



categories =[{:description => 'Business', :weight_sum => 0},
             {:description => 'Security', :weight_sum => 0},
             {:description => 'Finance', :weight_sum => 0},]
        
categories.each do |category|
  Category.create!(category)
end

scales = [{:level => 0, :score => 0.1, :description => 'BLevel 0',:category_id => Category.find_by(description: 'Business').id},
        {:level => 1, :score => 0.2, :description => 'BLevel 1',:category_id => Category.find_by(description: 'Business').id},
        {:level => 2, :score => 0.4, :description => 'BLevel 2',:category_id => Category.find_by(description: 'Business').id},
        {:level => 3, :score => 0.6, :description => 'BLevel 3',:category_id => Category.find_by(description: 'Business').id},
        {:level => 4, :score => 0.8, :description => 'BLevel 4',:category_id => Category.find_by(description: 'Business').id},
        {:level => 5, :score => 0.9, :description => 'BLevel 5',:category_id => Category.find_by(description: 'Business').id},
        {:level => 6, :score => 0.1, :description => 'BLevel 6',:category_id => Category.find_by(description: 'Business').id},
        {:level => 0, :score => 0.1, :description => 'SLevel 0',:category_id => Category.find_by(description: 'Security').id},
        {:level => 1, :score => 0.2, :description => 'SLevel 1',:category_id => Category.find_by(description: 'Security').id},
        {:level => 2, :score => 0.4, :description => 'SLevel 2',:category_id => Category.find_by(description: 'Security').id},
        {:level => 3, :score => 0.6, :description => 'SLevel 3',:category_id => Category.find_by(description: 'Security').id},
        {:level => 4, :score => 0.8, :description => 'SLevel 4',:category_id => Category.find_by(description: 'Security').id},
        {:level => 5, :score => 0.9, :description => 'SLevel 5',:category_id => Category.find_by(description: 'Security').id},
        {:level => 6, :score => 0.1, :description => 'SLevel 6',:category_id => Category.find_by(description: 'Security').id},
  	 ]

scales.each do |scale|
  Scale.create!(scale)
end

csv_file = File.read('db/BusinessSubcategoryWeights.csv')
csv=CSV.parse(csv_file,headers: true,skip_blanks: true).reject { |row| row.to_hash.values.all?(&:nil?) }

category=Category.find_by(description: 'Business')
new_weight_sum=0
csv.each do |row|
    subcategory={:subcategory_index => row['index'], 
                :weight => row['Default Category Weight (Equal Weight)'], 
                :description => row['SERVICE PROVIDER BUSINESS INFORMATION'], 
                :category_id => Category.find_by(description: 'Business').id,
                :weight_sum => 0,
                }
    #print(row['index'])
    
    new_weight_sum = new_weight_sum + subcategory[:weight].to_f #update weight sum
    Subcategory.create!(subcategory)
    
end

category.update(weight_sum: new_weight_sum)



csv_file = File.read('db/SecuritySubcategoryWeights.csv')
csv=CSV.parse(csv_file,headers: true,skip_blanks: true).reject { |row| row.to_hash.values.all?(&:nil?) }

category=Category.find_by(description: 'Security')
new_weight_sum=0

csv.each do |row|
    subcategory={:subcategory_index => row['Unique  Ref ID'], 
                :weight => row['Default'], 
                :description => row['Category'], 
                :category_id => Category.find_by(description: 'Security').id,
                :weight_sum => 0,
                }
    #print(row['index'])
    new_weight_sum=new_weight_sum + subcategory[:weight].to_f #update weight sum
    #print(new_weight_sum)
    #print("\n")
    Subcategory.create!(subcategory)
end

category.update(weight_sum: new_weight_sum)

csv_file = File.read('db/BusinessQuestionWeights.csv')
csv=CSV.parse(csv_file,headers: true).reject { |row| row.to_hash.values.all?(&:nil?) }
subcategory_index_fornow='NOT APPLICABLE'

csv.each do |row|
  if(row['User Defined Weights  (Sum = 1.00)']=='0')
    subcategory_index_fornow=row['index']
    new_weight_sum=0
  else
    question={:keyword => row['SERVICE PROVIDER BUSINESS INFORMATION'], 
              :index => row['index'], 
              :weight => row['Default Category Weight (Equal Weight)'], 
              :description => row['SERVICE PROVIDER BUSINESS INFORMATION'],
              #:category => 'B',
              :subcategory_id => Subcategory.find_by(subcategory_index: subcategory_index_fornow, category_id:Category.find_by(description: 'Business').id ).id}
    Question.create!(question)
    new_weight_sum +=question[:weight].to_f
  end
  if subcategory_index_fornow!='NOT APPLICABLE'
    subcategory=Subcategory.find_by(subcategory_index: subcategory_index_fornow, category_id:Category.find_by(description: 'Business').id )
    subcategory.update(weight_sum: new_weight_sum)
  end
end




csv_file = File.read('db/SecurityQuestionWeights.csv')
csv=CSV.parse(csv_file,headers: true,:encoding => 'ISO-8859-1').reject { |row| row.to_hash.values.all?(&:nil?) }
subcategory_index_fornow='NOT APPLICABLE'
new_weight_sum=0
csv.each do |row|
  if(row['Unique  Ref ID']!=nil)
    if(!(row['Unique  Ref ID']=~/-/))
      subcategory_index_fornow=row['Unique  Ref ID']
      new_weight_sum=0
    else
      question={:keyword => row['Category / Question'], 
              :index => row['Category / Question ID'], 
              :weight => row['Default'], 
              :description => row['Category / Question'],
              #:category => 'S',
              :subcategory_id => Subcategory.find_by(subcategory_index: subcategory_index_fornow, category_id:Category.find_by(description: 'Security').id ).id}
      Question.create!(question)
      new_weight_sum +=question[:weight].to_f
    end
    if subcategory_index_fornow!='NOT APPLICABLE'
      subcategory=Subcategory.find_by(subcategory_index: subcategory_index_fornow, category_id:Category.find_by(description: 'Security').id )
      subcategory.update(weight_sum: new_weight_sum)
    end
  end
end

questions =Question.all()
companies =Company.all()

companies.each do |company|
  questions.each do |question|
    answer={:company_id =>company.id, :question_id => question.id, :level =>0}
    Answer.create!(answer)
  end
end


#
