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
        # .joins is where we join two tables together, `left outer join` is where we are more forgiving
        # toward the left table which in this instance is the wikis table, meaning rows won't be removed
        # even if the don't make the cut, see the table but they should be displayed as `null` in the db.
        scope.joins('left outer join collaborations on wikis.id = collaborations.wiki_id').where("collaborations.user_id = ? OR wikis.user_id = ? OR wikis.private = ?", user, user, false)

        # example:
        # replace ?'s with false, true and user.id respectively.
        # where("(private = ?) OR (private = ? AND user_id = ?)", false, true, user.id)
      else
        scope.where(private: false)
      end
    end
  end
end
