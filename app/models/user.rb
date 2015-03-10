class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis

  def standard?
    role == "standard"
  end

  def premium?
    role == "premium"
  end

  def admin?
    role == "admin"
  end

  def upgrade_to_premium
    update_attributes(role: "premium")
  end
end
