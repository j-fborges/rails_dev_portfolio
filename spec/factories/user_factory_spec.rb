# spec/factories/user_factory_spec.rb (temporary)
require 'rails_helper'

RSpec.describe "User factory" do
  it "creates valid users with unique emails" do
    user1 = create(:user)
    user2 = create(:user)
    expect(user1.email).not_to eq(user2.email)
  end
end