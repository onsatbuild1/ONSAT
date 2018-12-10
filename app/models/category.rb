class Category < ActiveRecord::Base
    has_many :subcategories, dependent: :destroy
    has_many :companies, :through => :scores
    has_many :scales
end