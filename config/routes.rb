Rails.application.routes.draw do
  resources :appointments

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #since appointments is part of ActiveRecord as a resource (above), can state and specify resources

 get 'new' => 'appointments#new'

 root 'appointments#index'

end
