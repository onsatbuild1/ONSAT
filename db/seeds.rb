# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

questions = [{:keyword => 'Finance', :index => 1, :answer => 5, :weight => 0.5, :description => 'Example Question'},
    	  {:keyword => 'Security', :index => 2, :answer => 2, :weight => 2.0, :description => 'Example Question'},
    	  {:keyword => 'History', :index => 3, :answer => 3, :weight => 2.5, :description => 'Example Question'},
      	  {:keyword => 'Location', :index => 4, :answer => 6, :weight => 2.0, :description => 'Example Question'},
  	 ]

questions.each do |question|
  Question.create!(question)
end