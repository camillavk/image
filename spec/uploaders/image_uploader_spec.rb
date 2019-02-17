require 'carrierwave/test/matchers'

describe ImageUploader do
  include CarrierWave::Test::Matchers

  let(:subject) { described_class.new }
  let(:image_name) { 'test-image.jpg' }

  before do
    described_class.enable_processing = true
    File.open(path_to_file) { |f| subject.store!(f) }
  end

  after do
    described_class.enable_processing = false
    subject.remove!
  end

  context 'with correct image file' do
    let(:path_to_file) { "./spec/fixtures/images/#{image_name}" }

    it 'saves the image with the correct format' do
      expect(subject).to be_format 'jpeg'
    end

    it 'saves the image with a unique identifier (SecureRandom hex added to name)' do
      expect(subject.identifier.length).to eq 47
    end

    it 'saves the image with the original name included in the unique identifier' do
      expect(subject.identifier).to include(image_name)
    end
  end
end
