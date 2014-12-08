require 'sinatra'
require 'twilio-ruby'

require './phonebook'
require './directory_services'

# A populated Phonebook, suitable for searching
# @return [Phonebook]
def phonebook
  @phonebook ||= Phonebook.new.tap do |phonebook|
    DirectoryService.getDirectory(ENV['YP_PHONEBOOK_URI']).each do |name, phone|
      phonebook.add(name, phone)
    end
  end
end

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
  matches = phonebook.dialpad_search(params['Digits'])
  if matches.empty?
    Twilio::TwiML::Response.new do |r|
      r.Say 'No matches found.'
      r.Hangup
    end.text
  else
    name, number = matches.first
    Twilio::TwiML::Response.new do |r|
      r.Say "Connecting to #{name}"
      r.Dial(callerId: params['To']) { r.Number number }
    end.text
  end
end
