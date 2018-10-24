require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
    describe "upload" do
        it 'should upload a csv file' do
            @file = fixture_file_upload('test_1023.csv', 'text/csv')
            params = Hash.new
            params['file'] = @file
            post :upload, params
            puts(Question.where(keyword: "SERVICE PROVIDER IDENTIFICATION").inspect)
            assert Question.where(keyword: "SERVICE PROVIDER IDENTIFICATION").exists?
        end
    end
end
