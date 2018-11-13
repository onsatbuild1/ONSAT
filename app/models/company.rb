class Company < ActiveRecord::Base
    has_many :questions, :through => :answers
end