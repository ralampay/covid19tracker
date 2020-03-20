namespace :api do
  namespace :v1 do
    # Users
    post "/login", to: "users#login"

    # Survey Answers
    post "/survey_answers/create", to: "survey_answers#create"
    post "/survey_answers/submit_answer", to: "survey_answers#submit_answer"
    post "/survey_answers/finalize", to: "survey_answers#finalize"
  end
end
