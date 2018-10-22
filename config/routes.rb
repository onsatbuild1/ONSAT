Rottenpotatoes::Application.routes.draw do
  resources :questions
  # map '/' to be a redirect to '/questions'
  root :to => redirect('/questions')
end
