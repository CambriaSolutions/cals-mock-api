Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #

  namespace :v1 do
    resources :facilities do
      collection { get :search }
    end
  end
end
