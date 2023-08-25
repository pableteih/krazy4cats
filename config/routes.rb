Rails.application.routes.draw do
  resources :comments
  resources :publications do
    resources :comments, only: [:create]
  end
  devise_for :users
  post '/reactions', to: 'reactions#user_reaction', as: 'user_reaction'
  get '/my_reactions', to: 'reactions#publication_with_reactions', as: 'my_reactions'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "publications#index"
end
