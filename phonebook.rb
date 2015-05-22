# A directory of names and phone numbers
class Phonebook
  attr_accessor :data, :name_keypad_index

  DIALPAD = {
    '2' => 'abc',
    '3' => 'def',
    '4' => 'ghi',
    '5' => 'jkl',
    '6' => 'mno',
    '7' => 'pqrs',
    '8' => 'tuv',
    '9' => 'wxyz',
  }

  DIALPAD_INDEX = DIALPAD.each_with_object({}) do |(digit, letters), memo|
    letters.split('').each do |letter|
      memo[letter] = digit
    end
  end

  def initialize
    self.data = {}
  end

  # Add a contact to this phone book
  # @param name [String] The name of the contact
  # @param number [String] The phone number of the contact
  def add(name, number)
    data[name] = number
  end

  # Given a string of digits, find any matching names in the phonebook
  # @param digits [String] A string of digits
  # @return [Array<String>] A list of (name, number) pairs matching the digits
  def dialpad_search(digits)
    data.each.select do |name, _number|
      next unless name
      name.split.any? do |name_part|
        self.class.phoneword(name_part).start_with?(digits)
      end
    end
  end

  # convert a string into its dialpad equivalent
  # @param word [String]
  # @return [String]
  def self.phoneword(word)
    word.split('').map { |char| phoneletter(char) }.join
  end

  # convert a character into its dialpad equivalent
  # @param char [String]
  # @return [String]
  def self.phoneletter(char)
    DIALPAD_INDEX[char.downcase]
  end
end
