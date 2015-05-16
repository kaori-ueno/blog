require "rails_helper"

describe "comments/new", type: :view do
  before(:each) do
    @article = FactoryGirl.create :article
    @comment = FactoryGirl.build :comment
  end

  it "renders new comment form" do
    render

    assert_select "form[action=?][method=?]", comments_path, "post" do
      assert_select "textarea#comment_body[name=?]", "comment[body]"
    end
  end
end
