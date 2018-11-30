class Company < ActiveRecord::Base
    has_many :questions, :through => :answers
    has_many :categories, :through => :scores
    has_many :subcategories, :through => :scores
    has_and_belongs_to_many :coas
    has_many :self_coas, :class_name => "Coa", :foreign_key => "self_id"
end