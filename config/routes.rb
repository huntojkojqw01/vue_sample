Rails.application.routes.draw do
  root to: redirect("admin")

  get "admin(/*_)",      to: "admin#index"
  get "influencer(/*_)", to: "influencer#index"

  namespace :api do
    namespace :admin do
      resource :sessions, only: [:create, :destroy]
      resources :influencers, only: [:index, :show, :create, :update, :destroy]
    end

    namespace :influencer do
      resource :sessions, only: [:create, :destroy]
      resource :profiles, only: [:show, :create, :update]
    end
  end
end
