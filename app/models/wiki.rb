class Wiki < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user

  validates :user, presence: true
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true

  scope :private_wikis, -> (user) { where(private: true) }
  scope :public_wikis, -> (user) { where(private: false) }

  def public?
    self.private == false
  end

  def private?
    self.private == true
  end
end
