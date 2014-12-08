require './yp'
run Sinatra::Application

ENV['YP_PHONEBOOK_URI'] = 'https://docs.google.com/spreadsheets/d/1g_jgVF20i9Frqk66zaolOqW6HVk3gtr_ig25Vzl9tAo/export?format=csv&id=1g_jgVF20i9Frqk66zaolOqW6HVk3gtr_ig25Vzl9tAo&gid=0'

