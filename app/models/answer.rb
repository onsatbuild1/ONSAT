class Answer < ActiveRecord::Base
     belongs_to :question
     belongs_to :company
     
     def self.find_val(company_id, question_id)
         answer = Answer.find_by(question_id: question_id, company_id: company_id)
         return answer.validated
     end


     def self.find_level(company_id, question_id)
          answer = Answer.find_by(question_id: question_id, company_id: company_id) 
          return answer.level
     end  
     
     def self.upload(file,company_id)
        #csv=CSV.parse(file.path,headers: true,skip_blanks: true).reject { |row| row.to_hash.values.all?(&:nil?) }
        CSV.foreach(file.path, headers: true) do |row|
            if(row['index'])
                question=Question.find_by_description(row['description'])
                if(question)
                    answer=Answer.find_by(company_id: company_id, question_id:  question.id)
                    if(!answer)
                        return 0
                    else
                        answer.update(level: row['level'])
                    end
                end
            end
        end
        return 1
     end
end
