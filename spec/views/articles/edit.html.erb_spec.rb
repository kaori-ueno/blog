require 'rails_helper'

RSpec.describe "articles/edit", :type => :view do
  before(:each) do
    @article = assign(:article, FactoryGirl.create(:article, blog_id: 1))
  end

  it "renders the edit article form" do
    render

    assert_select "form[action=?][method=?]", article_path(@article), "post" do

      assert_select "input#article_title[name=?]", "article[title]"

      assert_select "input#article_body[name=?]", "article[body]"

      assert_select "input#article_blog_id[name=?]", "article[blog_id]"
    end
  end
end
