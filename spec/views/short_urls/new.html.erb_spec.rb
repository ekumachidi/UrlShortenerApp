require 'rails_helper'

RSpec.describe "short_urls/new", type: :view do
  before(:each) do
    assign(:short_url, ShortUrl.new(
      :original_url => "https://gist.github.com"
    ))
  end

  it "renders new short_url form" do
    render

    assert_select "form[action=?][method=?]", short_urls_path, "post" do
      assert_select "input[name=?]", "short_url[original_url]"
    end
  end
end
