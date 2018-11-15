class Company < ActiveRecord::Base
    has_many :questions, :through => :answers
    has_many :categories, :through => :scores
    has_many :subcategories, :through => :scores
end