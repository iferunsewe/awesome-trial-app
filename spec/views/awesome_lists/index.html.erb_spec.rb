require 'rails_helper'

RSpec.describe "awesome_lists/index", type: :view do
  before(:each) do
    assign(:awesome_lists, [
      create(:awesome_list, {
        technology: "Technology",
        category: "Category 1",
        repository: "repo/repo1"
      }),
      create(:awesome_list, {
        technology: "Technology",
        category: "Category 2",
        repository: "repo/repo1"
      })
    ])
  end

  it "renders a list of awesome_lists" do
    render
    assert_select "tr>td", text: "Technology".to_s, count: 2
    assert_select "tr>td", text: "Category 1".to_s, count: 1
    assert_select "tr>td", text: "repo/repo1".to_s, count: 2
  end
end
