require "rails_helper"

describe "comments/index", type: :view do
  let(:user) { FactoryGirl.create :user, id: 1 }
  let(:article) { FactoryGirl.create :article, id: 2 }

  before(:each) do
    assign(:comments, [
      FactoryGirl.create(:comment, owner: user, article: article),
      FactoryGirl.create(:comment, owner: user, article: article),
    ])
  end

  it "renders a list of comments" do
    render
    assert_select "tr>td", text: "Body".to_s, count: 2
    assert_select "tr>td", text: user.id.to_s, count: 2
    assert_select "tr>td", text: article.id.to_s, count: 2
  end
end
