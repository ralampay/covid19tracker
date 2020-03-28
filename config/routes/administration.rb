namespace :administration do
  resources :surveys do
    get "/stats", to: "surveys#stats", as: :stats
    resources :questions, only: [:new, :create, :edit, :update, :destroy] do
      resources :question_options, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  resources :users, only: [:index, :show] do
    get "/promote", to: "users#promote"
    get "/demote", to: "users#demote"
  end
end
