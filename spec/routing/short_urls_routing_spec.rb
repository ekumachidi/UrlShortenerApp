require "rails_helper"

RSpec.describe ShortUrlsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(:get => "/short_urls/new").to route_to("short_urls#new")
    end
  end
end
