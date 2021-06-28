Rails.application.routes.draw do
  post 'auth/register', to: 'application#account'

  namespace :api do
    namespace :v1 do
      resources :forms
      resources :mailing, only: :create do
        collection do
          post :account
          post :form
        end
      end
    end
  end
end
