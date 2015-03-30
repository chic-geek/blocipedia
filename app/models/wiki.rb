class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user

  # scope :visible_to, -> (user) { user ? where(private: true) : where.not(private: true) }
  scope :public_wikis, -> { where(private: false)}
end
