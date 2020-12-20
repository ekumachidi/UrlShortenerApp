require 'rails_helper'

RSpec.describe ShortUrlsController, type: :controller do
  let(:valid_attributes) do
    { original_url: 'http://github.com' }
  end

  let(:invalid_attributes) do
    { original_url: 'github.com' }
  end

  let(:valid_session) { {} }

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session

      expect(response).to be_successful
    end
  end

end
