Rails.application.routes.draw do
  scope :v1 do
    resources :pets, only: [:index, :show, :create] do
      member do
        get "matches", action: "matching"
      end
    end

    resources :customers, only: [:index, :show, :create] do
      member do
        get "matches"
      end
    end
  end
end
