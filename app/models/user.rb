class User < ActiveRecord::Base
  has_many :posts

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :displayname, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  def displayname?
    return displayname != nil && displayname != ""
  end
end
