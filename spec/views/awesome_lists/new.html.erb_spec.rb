require 'rails_helper'

RSpec.describe "awesome_lists/new", type: :view do
  before(:each) do
    assign(:awesome_list, AwesomeList.new(
      technology: "MyString",
      category: "Category",
      repository: "MyString"
    ))
  end

  it "renders new awesome_list form" do
    render

    assert_select "form[action=?][method=?]", awesome_lists_path, "post" do

      assert_select "input[name=?]", "awesome_list[technology]"

      assert_select "input[name=?]", "awesome_list[category]"

      assert_select "input[name=?]", "awesome_list[repository]"
    end
  end
end
