class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis

  def standard?
    role == "Standard"
  end

  def premium?
    role == "Premium"
  end

  def admin?
    role == "Admin"
  end
end
