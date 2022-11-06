Rails.application.routes.draw do
  resources :books

  namespace :api do
    namespace :v1 do
      resources :books, defaults:{format: :json}
    end
  end
end
