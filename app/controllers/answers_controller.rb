class AnswersController < ApplicationController
    def answer_params
        params.require(:answer).permit(:level)
    end
    
    def submit
        answers=Answer.all()
        answers.each do |answer|
            answer_str='answer'+answer.id.to_s
            if(params[answer_str.to_sym])
                #print(params[answer.id])
                if(params[answer_str.to_sym]!=answer.level)
                    answer.update(level: params[answer_str.to_sym])
                end
                #redirect_to questions_path, notice: params[answer.id]
            end
        end
        redirect_to questions_path, notice: "Submission Pushed"
    end
    
    def validate
        redirect_to questions_path, notice: "Submission Pushed"
    end
    
end