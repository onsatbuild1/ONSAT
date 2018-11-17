Rottenpotatoes::Application.routes.draw do
  devise_for :users
  resources :questions do
    collection { post :upload }
  end
  
  resources :home
  resources :formulae
  resources :output
  
  # map '/' to be a redirect to '/questions'
  root :to => redirect('/questions')
end
