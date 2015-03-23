class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user

  # scope :visible_to, -> (user) { user ? where(private: true) : where.not(private: true) }

  def self.visible_to(user)
    if user
      # replace ?'s with false, true and user.id respectively.
      # where("(private = ?) OR (private = ? AND user_id = ?)", false, true, user.id)
      where("private = ? OR user_id = ?", false, user.id)
    else
      where(private: false)
    end
  end
end
