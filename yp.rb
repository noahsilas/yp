require 'sinatra'

get '/' do
  'YellowPages'
end

post '/twilio/incoming' do
  <<-TWIML
<?xml version="1.0" encoding="UTF-8"?>
<Response>
  <Say voice="man">Hello World</Say>
</Response>
  TWIML
end
