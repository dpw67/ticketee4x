require "rails_helper"

RSpec.feature "Users can search for tickets matching specific criteria" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  
  let!(:ticket_1) do
    FactoryGirl.create(:ticket, title: "Create projects",
    project: project, author: user, tag_names: "iteration_1")
  end

  let!(:ticket_2) do
    FactoryGirl.create(:ticket, title: "Create users",
      project: project, author: user, tag_names: "iteration_2")
  end

  before do
    assign_role!(user, :manager, project)
    login_as(user)
    
    visit "/"
    click_link project.name
  end

  scenario "searching by tag" do
    fill_in "Search", with: "tag:iteration_1"
    click_button "Search"
    within("#tickets") do
      expect(page).to have_content("Create projects")
      expect(page).to_not have_content("Create users")
    end
  end
end
