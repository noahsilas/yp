require 'sinatra'
require 'twilio-ruby'

get '/' do
  'YellowPages'
end

post '/twilio/incoming' do
  Twilio::TwiML::Response.new do |r|
    r.Gather(action: '/twilio/search', finishOnKey: '#', numDigits: 3) do
      r.Say('Enter the first three letters of a name.', voice: 'woman')
    end
  end.text
end

post '/twilio/search' do
  Twilio::TwiML::Response.new do |r|
    params['Digits'].split('').each do |digit|
      r.Say digit
    end
  end.text
end
