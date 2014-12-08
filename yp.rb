require 'sinatra'
require 'twilio-ruby'

require './phonebook'
require './directory_service'

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
  query = params['Digits']
  matches = phonebook.dialpad_search(query)
  if matches.empty?
    Twilio::TwiML::Response.new do |r|
      r.Say 'No matches found.'
      r.Hangup
    end.text
  else
    if matches.length == 1
      connect_twiml(matches[0])
    else
      clarify_twiml(query, matches)
    end
  end
end

post '/twilio/search/:query/filter' do
  matches = phonebook.dialpad_search(params[:query])
  index = params['Digits'].to_i
  connect_twiml(matches[index])
end

def connect_twiml(match)
  name, number = match
  Twilio::TwiML::Response.new do |response|
    response.Say "Connecting to #{name}"
    response.Dial(callerId: params['To']) { response.Number number }
  end.text
end

def clarify_twiml(query, matches)
  # TODO: Handle the case where there are more than 10 matches.
  Twilio::TwiML::Response.new do |response|
    response.Gather(action: "/twilio/search/#{query}/filter", numDigits: 1) do
      matches.each_with_index do |(name, _number), index|
        response.Say "#{index} #{name}"
      end
    end
  end.text
end
