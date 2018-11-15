class Subcategory < ActiveRecord::Base
    has_many :questions, dependent: :destroy
    belongs_to :category
    has_many :companies, :through => :scores
end