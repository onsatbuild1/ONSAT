class Company < ActiveRecord::Base
    has_many :questions, :through => :answers
    has_many :categories, :through => :scores
    has_many :subcategories, :through => :scores
    has_many :coas, :through => :coa_weights
    has_many :self_coas, :class_name => "Coa", :foreign_key => "self_id"
    has_many :coa_weights
    has_many :answers
    has_and_belongs_to_many :sub_contractors, :class_name => "Company",
                                                :join_table => :subs,
                                                :association_foreign_key => :sub_company_id,
                                                :foreign_key => :company_id
end