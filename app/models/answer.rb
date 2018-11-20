class Answer < ActiveRecord::Base
     belongs_to :question
     belongs_to :company
     def self.find_level(company_id, question_id)
          answer = Answer.find_by(question_id: question_id, company_id: company_id) 
          return answer.level
     end  
     
     def self.form_symbol(company_id, question_id)
          answer = Answer.find_by(question_id: question_id, company_id: company_id)
          answer_str='answer'+answer.id.to_s
          return answer_str.to_sym
     end
     
     def self.upload(file)
        #csv=CSV.parse(file.path,headers: true,skip_blanks: true).reject { |row| row.to_hash.values.all?(&:nil?) }
        CSV.foreach(file.path, headers: true) do |row|
            if(!row['index'].nil?)
                if(!(row['index']<='Z'&&row['index']>='A'))
                    if(row['index']!= '0' )
                        answer=Answer.find_by(company_id: @company.id, question_id:  Question.find_by_index( row['index']).id)
                        answer.update(level: row['level'])
                    end
                end
            end
        end
     end
end