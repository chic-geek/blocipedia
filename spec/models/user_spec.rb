require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has role" do
    expect(User.new(role: "standard")).to have_attributes(role: "standard")
  end

  it "has standard role by default" do
    expect(User.new).to have_attributes(role: "standard")
  end

  it "has role set to standard" do
    user = User.new(role: "standard")
    expect(user.standard?).to eq(true)
  end

  it "has role set to premium" do
    user = User.new(role: "premium")
    expect(user.premium?).to eq(true)
  end

  it "has role set to admin" do
    user = User.new(role: "admin")
    expect(user.admin?).to eq(true)
  end
end
