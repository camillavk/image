describe ImagesController do
  let(:image_name) { 'test-image.jpg' }
  let(:path_to_file) { './spec/fixtures/images/test-image.jpg' }

  before do
    ImageUploader.enable_processing = true
  end

  after do
    ImageUploader.enable_processing = false
  end

  describe '#POST upload' do
    subject { post :upload, params }
    let(:params) { { image_path: path_to_file } }

    it 'returns a 200 status' do
      subject
      expect(response.status).to eq 200
    end

    it 'returns the file name' do
      subject
      expect(JSON.parse(response.body)['image_name']).to include image_name
    end

    context 'with missing image path params' do
      let(:params) { nil }

      it 'raises ParameterMissing error' do
        expect { subject }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  describe '#GET retrieve' do
    subject { get :retrieve, params }
    let(:params) { { image_name: image_name } }

    before do
      uploader = ImageUploader.new
      File.open(path_to_file) { |f| uploader.store!(f) }
    end

    it 'returns a 200 status' do
      subject
      expect(response.status).to eq 200
    end

    it 'returns the image url' do
      subject
      expect(JSON.parse((response.body))['file'].present?).to eq true
    end
  end
end
