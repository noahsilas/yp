# A directory of names and phone numbers
class Phonebook
  attr_accessor :data

  def initialize()
    self.data = {}
  end

  # Add a contact to this phone book
  # @param name [String] The name of the contact
  # @param number [String] The phone number of the contact
  def add(name, number)
    data[name] = number
  end
end
