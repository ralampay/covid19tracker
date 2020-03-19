namespace :api do
  namespace :v1 do
    # Users
    post "/login", to: "users#login"

    # Survey Answers
    post "/survey_answers/create", to: "survey_answers#create"
  end
end
