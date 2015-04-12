class Wiki < ActiveRecord::Base
  belongs_to :user, dependent: :destroy

  scope :private_wikis, -> (user) { where(private: true) }
  scope :public_wikis, -> (user) { where(private: nil) }

end
