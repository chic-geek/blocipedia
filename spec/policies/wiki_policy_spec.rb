require 'rails_helper'

describe WikiPolicy do
  subject { WikiPolicy }

  permissions :create? do
    it "allows a user to create a wiki" do
      user = create(:user)
      wiki = create(:wiki, user: user)
      expect(WikiPolicy).to permit(user, wiki)

      # the param passed into the expect is actually the `subject` above,
      # this could quite easily be written as `expect(subject)`
      #
      # the params passed to the permit method are the @user and @record
      # set in poliies/application_policy.rb, above is passing in the
      # user created and the record, which in this instance is wiki as
      # this is the WikiPolicy.
    end
  end

  permissions :show? do
    it "prevents access to anonymous users" do
      expect(subject).not_to permit(nil, create(:wiki))

      # to simulate an anonymous user, don't pass in a user object,
      # instead pass in nil.
    end
  end

  permissions :update? do
    it "allows authorised user to update wiki" do
      user = create(:user)
      wiki = create(:wiki, user: user)
      expect(subject).to permit(user, wiki)
    end

    it "prevents anonymous user from updating a wiki" do
      expect(subject).not_to permit(nil, Wiki.new)
    end

    it "prevents users updating another users wiki" do
      user = create(:user)
      wiki = create(:wiki, user: create(:user))
      expect(subject).not_to permit(user, wiki)
    end
  end

  permissions :destroy? do
    it "prevents anonymous users from deleting a wiki" do
      expect(subject).not_to permit(nil, Wiki.new)
    end

    it "prevents users deleting another users wiki" do
      user = create(:user)
      wiki = create(:wiki, user: create(:user))
      expect(subject).not_to permit(user, wiki)

      # in the above data setup, the `wiki` variable is creating
      # a new wiki and also a new user (in memory / on the fly)
      # plus another new user.
    end
  end
end
