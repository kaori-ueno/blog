require 'rails_helper'

RSpec.describe "blogs/show", :type => :view do
  before(:each) do
    user = FactoryGirl.create :user, id: 1
    @blog = assign :blog, FactoryGirl.create(:blog, user_id: user.id)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/#{@blog.name}/)
    expect(rendered).to match(/#{@blog.user_id}/)
  end
end
