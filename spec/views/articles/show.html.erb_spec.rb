require 'rails_helper'

RSpec.describe "articles/show", :type => :view do
  before(:each) do
    blog = FactoryGirl.create :blog, id: 1
    @article = assign :article, FactoryGirl.create(:article, blog_id: blog.id)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/#{@article.title}/)
    expect(rendered).to match(/#{@article.body}/)
    expect(rendered).to match(/#{@article.blog_id}/)
  end
end
