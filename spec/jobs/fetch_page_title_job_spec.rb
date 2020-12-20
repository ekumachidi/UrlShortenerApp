require 'rails_helper'

RSpec.describe FetchPageTitleJob, type: :job do
  let(:job) { described_class.new }
  let(:short_url) { create(:short_url) }

  describe '#perform' do
    subject { job.perform(short_url) }

    it 'updates the visit count of the given short_url' do
      allow(short_url).to receive(:update_attribute)
      subject
      expect(short_url).to have_received(:update_attribute)
    end
  end
end
