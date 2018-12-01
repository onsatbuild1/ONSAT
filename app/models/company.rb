class Company < ActiveRecord::Base
    has_many :questions, :through => :answers
    has_many :categories, :through => :scores
    has_many :subcategories, :through => :scores
    has_many :coas, :through => :coa_weights
    has_many :self_coas, :class_name => "Coa", :foreign_key => "self_id"
    has_many :coa_weights
end