class AnswersController < ApplicationController
    def answer_params
        params.require(:answer).permit(:level, :validated)
    end
    
    def submit
        if(params[:commit]=='Validate' && current_user.role == 'Validator')
            answers=Answer.where(company_id: params[:company_id])
            answers.each do |answer|
                if(params[:answer_vals])
                    if(params[:answer_vals][answer.id.to_s]!=answer.validated)
                        answer.update(validated: params[:answer_vals][answer.id.to_s])
                    end
                end
            end
            redirect_to questions_path, notice: 'Validated'
        elsif (params[:commit]=='Submit' && current_user.role == 'Company Representative')
            answers=Answer.where(company_id: params[:company_id])
            answers.each do |answer|
                if(params[:answers])
                    #print(params[answer.id])
                    if(params[:answers][answer.id.to_s]!=answer.level)
                        answer.update(level: params[:answers][answer.id.to_s],validated: false)
                    end
                    #redirect_to questions_path, notice: params[answer.id]
                end
            end
            redirect_to questions_path, notice: 'Submission Pushed'
        end
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
    
    def download
        send_file "#{Rails.root}/app/assets/sample.pdf"
    end
end
