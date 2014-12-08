require './directory_service'

describe DirectoryService do
  describe '.getDirectory' do

    let(:url) { 'https://docs.google.com/spreadsheets/d/1g_jgVF20i9Frqk66zaolOqW6HVk3gtr_ig25Vzl9tAo/export?format=csv&id=1g_jgVF20i9Frqk66zaolOqW6HVk3gtr_ig25Vzl9tAo&gid=0' }

    it 'gets the directory' do
      directory = DirectoryService.getDirectory(url)
      expect(directory["bob"]).to eq("555-123-1234")
    end
  end
end
