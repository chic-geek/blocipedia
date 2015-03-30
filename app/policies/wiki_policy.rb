class WikiPolicy < ApplicationPolicy

  def index?
    public_or_visible
  end

  # Stop user from seeing a private wiki by typing in private wiki url.
  def show?
    public_or_visible
  end

  private

  def public_or_visible
    return true unless record.private?

    user.present? && (record.user == user || user.admin?)
  end

  class Scope < Scope
    def resolve
      if user
        # replace ?'s with false, true and user.id respectively.
        # where("(private = ?) OR (private = ? AND user_id = ?)", false, true, user.id)
        scope.where("user_id = ?", user.id)
      else
        scope.where(private: false)
      end
    end
  end
end
