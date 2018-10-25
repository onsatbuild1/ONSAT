class Question < ActiveRecord::Base

    def self.upload(file)
        CSV.foreach(file.path, headers: true) do |row|
            question_hash = row.to_hash
            question = self.where(id: question_hash["index"])
            if question.present?
                question.first.update_attributes(question_hash)
            else
                self.create!(question_hash)
            end
            
        end
    end
end
