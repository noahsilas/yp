require 'sinatra'
require 'twilio-ruby'
require './directory_services'

# Essentially transfer the hash from directoryServices to Phonebook
# @param phonebook [Phonebook] The global phonebook with search cababilities
# @return nil
def getDirectory(phonebook)
  DirectoryService.getDirectory(ENV['YP_PHONEBOOK_URI']).each do |name, phone|
    phonebook.add(name, phone)
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
  Twilio::TwiML::Response.new do |r|
    params['Digits'].split('').each do |digit|
      r.Say digit
    end
  end.text
end
