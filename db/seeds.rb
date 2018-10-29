# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

questions = [{:keyword => 'Finance Question', :index => 1, :category_id => 2, :answer => 5, :weight => 0.5, :description => 'Example Question'},
    	  {:keyword => 'Security Question', :index => 2, :category_id => 1, :answer => 2, :weight => 2.0, :description => 'Example Question'},
    	  {:keyword => 'Business Question', :index => 3, :category_id => 2, :answer => 3, :weight => 2.5, :description => 'Example Question'},
  	 ]

questions.each do |question|
  Question.create!(question)
end