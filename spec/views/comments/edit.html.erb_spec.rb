require "rails_helper"

describe "comments/edit", type: :view do
  before(:each) do
    @comment = FactoryGirl.create :comment
    @article = @comment.article
  end

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", comment_path(@comment), "post" do
      assert_select "textarea#comment_body[name=?]", "comment[body]"
    end
  end
end
