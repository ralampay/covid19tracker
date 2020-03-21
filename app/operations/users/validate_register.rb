module Users
  class ValidateRegister
    def initialize(first_name:, last_name:, username:, email:, password:, password_confirmation:)
      @first_name             = first_name
      @last_name              = last_name
      @username               = username
      @email                  = email
      @password               = password
      @password_confirmation  = password_confirmation

      @errors = []
    end

    def execute!
      if @username.blank?
        @errors << "username required"
      elsif User.where(username: @username).count > 0
        @errors << "username already taken"
      end

      if @email.blank?
        @errors << "email required"
      elsif User.where(email: @email).count > 0
        @errors << "email already taken"
      end

      if @first_name.blank?
        @errors << "first_name required"
      end

      if @last_name.blank?
        @errors << "last_name required"
      end

      if @password.blank?
        @errors << "password required"
      end

      if @password_confirmation.blank?
        @errors << "password_confirmation required"
      end

      if @password.present? and @password_confirmation.present?
        if @password != @password_confirmation
          @errors << "passwords do not match"
        end

        if @password.length < 6 || @password_confirmation.length < 6
          @errors << "password should be at least 6 characters"
        end
      end

      @errors
    end
  end
end
