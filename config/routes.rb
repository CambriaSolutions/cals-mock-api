Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #

  namespace :v1 do
    resources :facilities do
      collection do
        get 'search', action: :search_query
        post 'search', action: :search_post
        # get :search
        # post :full_text_search
      end
    end
  end
end
