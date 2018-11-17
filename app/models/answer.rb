class Answer < ActiveRecord::Base
     belongs_to :question
     belongs_to :company
     def self.find_level(company_id, question_id)
          answer = Answer.find_by(question_id:question_id, company_id:company_id) 
          return answer.level
     end  
     
     def self.form_string(company_id, question_id)
          answer = Answer.find_by(question_id:question_id, company_id:company_id)
          answer_str='answer'+answer.id.to_s
          return answer_str
     end
end