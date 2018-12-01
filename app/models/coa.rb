class Coa < ActiveRecord::Base
    has_many :coa_weights
    has_many :companies, :through => :coa_weights
    belongs_to :self, :class_name => "Company", :foreign_key => "self_id"
end