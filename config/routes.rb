Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :mailing, only: :create do
        collection do
          post :account
          post :form
        end
      end
    end
  end
end
