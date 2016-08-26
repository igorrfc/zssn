Rails.application.routes.draw do
  namespace :api, path: '/', constraints: { subdomain: 'api' } do
    resources :infected_reports, except: [:destroy, :patch, :put, :get]
    resources :reports do
      collection do
        get :infected_survivors
        get :non_infected_survivors
      end
    end
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
