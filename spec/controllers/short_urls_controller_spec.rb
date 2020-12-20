require 'rails_helper'

RSpec.describe ShortUrlsController, type: :controller do
  let(:valid_attributes) do
    { original_url: 'http://github.com' }
  end

  let(:invalid_attributes) do
    { original_url: 'github.com' }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      ShortUrl.create! valid_attributes

      get :index

      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    context 'when the slug is invalid' do
      it 'returns a 404' do
        get :show, params: { id: 'sdf' }, session: valid_session

        expect(response.status).to be(404)
      end
    end

    context 'when the slug is valid' do
      it 'returns a success response' do
        short_url = ShortUrl.create! valid_attributes

        get :show, params: { id: short_url.slug }, session: valid_session

        expect(response).to redirect_to short_url.original_url
      end
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session

      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new ShortUrl' do
        expect do
          post :create, params: { short_url: valid_attributes }, session: valid_session
        end.to change(ShortUrl, :count).by(1)
      end

      it 'queues a job to fetch the page title' do
        allow(FetchPageTitleJob).to receive(:perform_later)

        post :create, params: { short_url: valid_attributes }, session: valid_session

        expect(FetchPageTitleJob).to have_received(:perform_later)
      end

      it 'redirects to the homepage' do
        post :create, params: { short_url: valid_attributes }, session: valid_session

        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. display the 'new' template)" do
        post :create, params: { short_url: invalid_attributes }, session: valid_session

        expect(response).to be_successful
      end
    end
  end
end
