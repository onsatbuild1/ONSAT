class AnswersController < ApplicationController
    def answer_params
        params.require(:answer).permit(:level)
    end
    
    def submit
        answers=Answer.where(company_id: params[:company_id])
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
        redirect_to questions_path, notice: 'Submission Pushed'
    end
    
    def validate
        redirect_to questions_path, notice: 'Submission Pushed'
    end


    def upload
        if params[:file].present?
            file_flag=Answer.upload(params[:file],params[:company_id])
            if(file_flag==1)
                redirect_to questions_path, notice: 'Upload Successful'
            else
                redirect_to questions_path, notice: 'File Invalid'
            end
        else
            redirect_to questions_path, notice: 'No file chosen'
        end
    end
end