Rails.application.routes.draw do
  get 'cart/index'

  resources :items
  root 'static_pages#home'
  

  get '/help', to: 'static_pages#help'

  get '/about', to: 'static_pages#about'
  
  get '/login', to: 'user#login'
  
  get '/logout', to: 'user#logout'
  
  get '/cart', to: 'cart#index'
  
  get '/cart/:id', to: 'cart#add'
  
  get '/cart/remove/:id', to: 'cart#remove'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
