namespace :api do
  namespace :v1 do
    # Users
    post "/login", to: "users#login"
    post "/register", to: "users#register"
    post "/users/resend_confirmation", to: "users#resend_confirmation"
    post "/users/change_password", to: "users#change_password"
    post "/users/update_group_name", to: "users#update_group_name"
    post "/users/update_company", to: "users#update_company"

    # Survey Answers
    post "/survey_answers/create", to: "survey_answers#create"
    post "/survey_answers/submit_answer", to: "survey_answers#submit_answer"
    post "/survey_answers/finalize", to: "survey_answers#finalize"
  end
end
