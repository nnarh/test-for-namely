require 'rails_helper'

RSpec.describe User, type: :model do

  FactoryGirl.create(:user, provider: "namely_test", uid: 982939011, name: "tester")

  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end
end
