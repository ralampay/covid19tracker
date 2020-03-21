namespace :tests do
  task :send_email => :environment do
    include SendGrid

    from    = ENV['FROM']
    to      = ENV['TO']
    subject = ENV['SUBJECT']
    content = ENV['CONTENT']

    from    = Email.new(email: from)
    to      = Email.new(email: to)
    content = Content.new(type: 'text/plain', value: content)
    mail    = Mail.new(from, subject, to, content)

    sg        = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response  = sg.client.mail._('send').post(request_body: mail.to_json)

    puts response.status_code
    puts response.body
    puts response.headers
  end
end
