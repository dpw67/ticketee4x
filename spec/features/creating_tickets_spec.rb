require "rails_helper"

RSpec.feature "Creating Tickets" do

  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user)
    
    project = FactoryGirl.create(:project, name: "Internet Explorer")
    assign_role!(user, :editor, project)
    
    visit "/"
    click_link "Internet Explorer"
    click_link "New Ticket"
  end

  scenario "with valid attributes" do
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Ticket"
    
    expect(page).to have_content("Ticket has been created.")
    within("#ticket #author") do
      expect(page).to have_content("Created by #{user.email}")
    end
  end

  scenario "with missing fields" do
    click_button "Create Ticket"
    
    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end
  
  scenario "with an invalid description" do
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "It sucks"
    click_button "Create Ticket"
  
    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Description is too short")
  end
  
  scenario "with an attachment" do
    fill_in "Title", with: "Add documentation for blink tag"
    fill_in "Description", with: "The blink tag has a speed attribute"
    attach_file "File", "spec/fixtures/speed.txt"
    click_button "Create Ticket"
    
    expect(page).to have_content("Ticket has been created.")
    within("#ticket .asset") do
      expect(page).to have_content("speed.txt")
    end
  end
  
end
