module Users
  class Register
    include SendGrid

    def initialize(first_name:, last_name:, username:, email:, password:, password_confirmation:)
      @user = User.new(
                first_name: first_name,
                last_name: last_name,
                username: username,
                email: email,
                password: password,
                password_confirmation: password_confirmation,
                role: "USER",
                confirmation_token: "#{SecureRandom.hex(32)}"
              )

      @host = ENV['HOST'] || "http://localhost:3000/confirm"
    end

    def execute!
      ActiveRecord::Base.transaction do
        @user.save!

        from    = Email.new(email: "info@covid19responsehub.ph")
        to      = Email.new(email: @user.email)
        subject = "Email Confirmation"
        content = Content.new(
                    type: "text/html",
                    value: "<h2>Please Click to Confirm</h2><a href='#{@host}/#{@user.confirmation_token}' target='_blank'>Confirm Now</a>"
                  )

        mail      = Mail.new(from, subject, to, content)
        sg        = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        response  = sg.client.mail._('send').post(request_body: mail.to_json)
      end
    end
  end
end
