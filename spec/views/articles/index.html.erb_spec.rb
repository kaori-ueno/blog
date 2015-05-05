require 'rails_helper'

RSpec.describe "articles/index", :type => :view do
  before(:each) do
    assign(:articles, [
      FactoryGirl.create(:article, blog_id: 1),
      FactoryGirl.create(:article, blog_id: 1),
    ])
  end

  it "renders a list of articles" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Body".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
