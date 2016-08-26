Rails.application.routes.draw do
  namespace :api, path: '/', constraints: { subdomain: 'api' } do
    resources :survivors, except: [:destroy] do
      member do
       patch :update_location
       put :update_location
       patch :trade
       put :trade
      end
    end
  end

end
