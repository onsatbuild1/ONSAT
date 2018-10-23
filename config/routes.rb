Rottenpotatoes::Application.routes.draw do
  resources :questions do
    collection { post :upload }
  end
  # map '/' to be a redirect to '/questions'
  root :to => redirect('/questions')
end
