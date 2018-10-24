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
    
    describe "create question and questions page should render" do
        it 'should render the questions page' do
            get :index
            expect(response).to render_template('index')
        end
        
        it 'should render the create question view' do
            get :new
            expect(response).to render_template('new')
        end
    end
    
    describe "show page works" do
        question = Question.create({:keyword => 'test', :answer => 'no answer', :weight => '0', :index => '0'})
        
        it 'should render successfully' do
            get :show, :id => question.id
            assert :success
        end
        it 'should render the show view' do
            get :show, :id => question.id
            expect(response).to render_template('show')
        end
        it 'should display the right movie' do
            get :show, :id => question.id
            expect(assigns(:question)).to eq(question)
        end
    end
    
    describe "create question works" do
        it "creates a new question" do
            post :create, :question => {:keyword => 'testkey', :answer => 'none', :description => 'undefined', :index => '0'}
            expect(assigns(:question)).should_not be_nil
        end
    end
end
