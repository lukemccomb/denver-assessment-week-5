feature "logged out user can see homepage" do
  before(:each) do
    visit "/"
  end
  scenario "user sees contacts" do
    expect(page).to have_content("Contacts")
  end
end