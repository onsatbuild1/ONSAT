class Score < ActiveRecord::Base
    belongs_to :category
    belongs_to :subcategory
    belongs_to :company
end