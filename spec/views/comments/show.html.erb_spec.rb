require "rails_helper"

describe "comments/show", type: :view do
  let(:user) { FactoryGirl.create :user, id: 1 }
  let(:article) { FactoryGirl.create :article, id: 2 }
  let(:comment) { FactoryGirl.create :comment, owner: user, article: article }

  before(:each) do
    @comment = assign :comments, comment
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/#{comment.body}/)
    expect(rendered).to match(/#{user.id}/)
    expect(rendered).to match(/#{article.id}/)
  end
end
