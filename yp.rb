require 'sinatra'

get '/' do
  'YellowPages'
end

post '/twilio/incoming' do
  <<-TWIML
<?xml version="1.0" encoding="UTF-8"?>
<Response>
  <Gather action="/twilio/search" finishOnKey='#' numDigits='3'>
    <Say voice="man">Enter the first three letters of a name.</Say>
  </Gather>
</Response>
  TWIML
end

post '/twilio/search' do
  response = <<-TWIML
<?xml version="1.0" encoding="UTF-8"?>
<Response>
  TWIML

  params['Digits'].split('').each do |digit|
    response << "  <Say>#{digit}</Say>\n"
  end

  response << <<-TWIML
</Response>
  TWIML
end
