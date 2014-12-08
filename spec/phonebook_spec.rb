require './phonebook'

describe Phonebook do
  describe '.phoneletter' do
    it 'maps lowercase letters to numbers' do
      expect(Phonebook.phoneletter('a')).to eq('2')
    end

    it 'maps uppercase letters to numbers' do
      expect(Phonebook.phoneletter('N')).to eq('6')
    end
  end

  describe '.phoneword' do
    it 'maps a word to numbers' do
      expect(Phonebook.phoneword('Noah')).to eq('6624')
      expect(Phonebook.phoneword('Jerroyd')).to eq('5377693')
    end
  end
end
