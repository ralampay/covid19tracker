module Administration
  class SurveysController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin!
  end
end
