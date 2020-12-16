require "rails_helper"

RSpec.describe "Logging in with slack", type: :feature do
  let(:slack_id) { "raw_slack_id_12345" }
  let(:hashed_id) { Digest::SHA256.hexdigest(slack_id) }
  let(:user) { create(:user, slack_id: hashed_id) }

  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:slack] = OmniAuth::AuthHash.new(
      info: {
        user_id: slack_id
      }
    )
  end

  scenario "shows logout link" do
    visit root_path
    click_link
    expect(page).to have_content(hashed_id)
    expect(page).to have_link("Logout")
    expect(current_path).to eq profile_path
  end
end
