class Coa < ActiveRecord::Base
    has_and_belongs_to_many :companies
    belongs_to :self, :class_name => "Company", :foreign_key => "self_id"
end