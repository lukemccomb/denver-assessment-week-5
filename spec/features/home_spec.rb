feature "logged out user can see homepage" do
  before(:each) do
    visit "/"
  end
  scenario "user sees contacts and log in" do
    expect(page).to have_content("Contacts")
    expect(page).to have_content("Log In")
  end
  scenario "user can click log in and be brought to new page" do
    click_on "Log In"
    expect(page).to have_content("Username:")
    expect(page).to have_content("Password:")
    expect(page).to have_button("Submit")
    fill_in "Username:", with: "Jeff"
    fill_in "Password:", with: "jeff123"
    click_on "Submit"
    expect(page).to have_content("Welcome, Jeff")
    expect(page).to have_content("Log Out")
    click_on "Log Out"
    expect(page).to have_content("Log In")
    expect(page).to have_content("Contacts")
  end
end