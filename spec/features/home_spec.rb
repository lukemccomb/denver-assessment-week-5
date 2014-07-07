feature "logged out user can see homepage" do
  before(:each) do
    visit "/"
  end
  scenario "user sees contacts" do
    expect(page).to have_content("Contacts")
    expect(page).to have_link("Log In", href: "/log_in")
    click_on "Log In"
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
    expect(page).to have_button("Submit")
  end
end