require 'rails_helper'

RSpec.describe User, type: :model do

  @user = FactoryGirl.create(:user, provider: "namely", uid: Faker::Number.number(10), name: "test")

  it "has a valid factory" do
    expect{ @user }.to be_valid
  end

  it "should raise db error when validation is skipped" do
    expect { @user.save!(validate: false) }.to raise_error
  end
end
