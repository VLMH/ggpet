Rails.application.routes.draw do
  scope :v1 do
    resources :pets, only: [:index, :show, :create] do
      member do
        get "matches", action: "matching"
      end
    end

    resources :customers, only: [:index, :show, :create] do
      member do
        get "matches", action: "matching"
        get "adoptions", action: "adoptions"
        post "adoptions", action: "adopt"
      end
    end
  end
end
