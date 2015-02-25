require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has role" do
    expect(User.new(role: "Standard")).to have_attributes(role: "Standard")
  end

  it "has standard role by default" do
    expect(User.new).to have_attributes(role: "Standard")
  end

  it "has role set to standard" do
    user = User.new(role: "Standard")
    expect(user.standard?).to eq(true)
  end

  it "has role set to premium" do
    user = User.new(role: "Premium")
    expect(user.premium?).to eq(true)
  end

  it "has role set to admin" do
    user = User.new(role: "Admin")
    expect(user.admin?).to eq(true)
  end
end
