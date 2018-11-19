Rottenpotatoes::Application.routes.draw do
  resources :questions do
    collection { post :upload }
  end
  
  resources :answers do
    collection { put :submit,:validate}
    collection { post :upload}
  end
  
  resources :home
  resources :formulae
  resources :output
  
  # map '/' to be a redirect to '/questions'
  root :to => redirect('/questions')
end
