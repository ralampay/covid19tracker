Rails.application.routes.draw do
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end

  devise_for :users, skip: [:sessions]

  as :user do
    get 'login', to: 'pages#login', as: :new_user_session
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  root to: "pages#index"
  get "/profile", to: "pages#profile", as: :profile
  get "/register", to: "pages#register", as: :register
  get "/confirm/:confirmation_token", to: "pages#confirm", as: :confirm
  get "/resend_confirmation", to: "pages#resend_confirmation", as: :resend_confirmation

  resources :patients
  resources :establishments
  resources :survey_answers, only: [:index, :show, :destroy]

  draw :administration
  draw :api
end
