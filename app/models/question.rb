class Question < ActiveRecord::Base
    attr_accessible :keyword, :answer, :weight, :index
    
    
    def self.upload(file)
        CSV.foreach(file.path, headers: true) do |row|
            question = find_by_id(row["index"]) || new
            question.attributes = row.to_hash.slice(*accessible_attributes)
            product.save!
        end
    end
end
