module Users
  class ResendConfirmation
    include SendGrid

    def initialize(user:)
      @user = user
      @host = ENV['MY_HOST'] || "http://localhost:3000"
    end

    def execute!
      ActiveRecord::Base.transaction do
        from    = Email.new(email: "info@covid19responsehub.ph")
        to      = Email.new(email: @user.email)
        subject = "Email Confirmation"
        content = Content.new(
                    type: "text/html",
                    value: "<h2>Please Click to Confirm</h2><a href='#{@host}/confirm/#{@user.confirmation_token}' target='_blank'>Confirm Now</a>"
                  )

        mail      = Mail.new(from, subject, to, content)
        sg        = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        response  = sg.client.mail._('send').post(request_body: mail.to_json)
      end
    end
  end
end
