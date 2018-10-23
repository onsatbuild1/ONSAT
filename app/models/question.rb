class Question < ActiveRecord::Base
    attr_accessible :keyword, :answer, :weight
    
    
    def self.upload(file)
        CSV.foreach(file.path, headers: true) do |row|
            Product.create! row.to_hash
        end
    end
end
