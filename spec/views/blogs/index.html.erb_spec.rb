require 'rails_helper'

RSpec.describe "blogs/index", :type => :view do
  before(:each) do
    assign(:blogs, [
      Blog.create!(
        :name => "Name",
        :user_id => 1
      ),
      Blog.create!(
        :name => "Name",
        :user_id => 1
      )
    ])
  end

  it "renders a list of blogs" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
