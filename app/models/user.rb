class User < ActiveRecord::Base
  has_many :wikis
  has_many :collaborations
  has_many :collaborated_wikis, through: :collaborations, source: :wiki
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  after_create :initialize_user

  def admin?
    role == 'admin'
  end

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def initialize_user
    self.update_attributes(role: 'standard')
  end

  def upgrade_account
    self.update_attributes(role: 'premium')
  end
end