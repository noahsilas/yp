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

  describe '.dialpad_search' do
    let(:noah) { ['Noah Silas', '310 555 0000'] }
    let(:jerroyd) { ['Jerroyd Moore', '415 555 1234'] }

    let(:phonebook) do
      Phonebook.new.tap do |pb|
        pb.add(jerroyd[0], jerroyd[1])
        pb.add(noah[0], noah[1])
      end
    end

    subject { phonebook.dialpad_search(query) }

    context 'when the query does not match anything in the phone book' do
      let(:query) { '2' } # 'A|B|C'
      it { should be_empty }
    end

    context 'when the query matches a first name' do
      let(:query) { '6' } # 'M|N|O'
      it { should include(noah) }
    end

    context 'when the query matches a last name' do
      let(:query) { '666' } # /[MNO]{3}/ =~ MOORE
      it { should include(jerroyd) }
    end

    context 'with multiple matches' do
      let(:query) { '66' } # /[MNO]{2} =~ (MOORE, NOAH)
      it 'includes all the matches' do
        expect(subject).to include(noah)
        expect(subject).to include(jerroyd)
      end
    end
  end
end
