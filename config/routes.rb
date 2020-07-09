# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :basic_compos do
        member do
          patch :update_slot
        end
      end
      resources :rosters do
        member do
          patch :update_slot
        end
      end
      resources :character_roster_roles
      resources :characters do
        collection do
          get :all
        end
      end
    end
  end

  root to: 'home#index'

  post 'refresh', controller: :refresh, action: :create
  post 'signup', controller: :signup, action: :create
  post 'signin', controller: :signin, action: :create
  delete 'signout', controller: :signin, action: :destroy
end
