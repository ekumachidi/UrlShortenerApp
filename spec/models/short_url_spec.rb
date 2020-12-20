require 'rails_helper'

RSpec.describe ShortUrl, type: :model do

  let(:url) { ShortUrl.create(original_url: "http://github.com") }

  subject{ url }

  describe "Validations" do
    it { should validate_presence_of(:original_url) }
    it { should validate_length_of(:original_url) }
    it { should validate_uniqueness_of(:original_url) }
    it { should allow_value("http://github.com").for(:original_url) }
    it { should_not allow_value("github.com").for(:original_url) }
    it { should_not allow_value("http://x.c").for(:original_url) }
    it { should validate_uniqueness_of(:slug) }

    it "is invalid without an original_url" do
      expect(ShortUrl.new).to be_invalid
    end

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "should generate_slug" do
      url.slug.should be_present
    end
  end

end
