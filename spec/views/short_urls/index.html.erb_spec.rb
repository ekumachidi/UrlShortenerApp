require 'rails_helper'

RSpec.describe "short_urls/index", type: :view do
  before(:each) do
    assign(:short_urls, [
      ShortUrl.create!(
        :original_url => "http://github.com",
        :visits => 2,
        :title => "Title1"
      ),
      ShortUrl.create!(
        :original_url => "http://ekumachidi.github.io",
        :visits => 2,
        :title => "Title2"
      )
    ])
  end

  it "renders a list of short_urls" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
