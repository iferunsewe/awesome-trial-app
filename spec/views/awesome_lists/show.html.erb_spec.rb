require 'rails_helper'

RSpec.describe "awesome_lists/show", type: :view do
  before(:each) do
    @awesome_list = assign(:awesome_list, create(:awesome_list, {
      technology: "Technology",
      category: "Category",
      repository: "repo/repo1"
    }))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Technology/)
    expect(rendered).to match(/Category/)
    expect(rendered).to match(/repo\/repo1/)
  end
end
