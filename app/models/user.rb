class User < ApplicationRecord
  belongs_to :identifiable, polymorphic: true
  validates_uniqueness_of :username
  has_secure_password

  def get_proper_name
    usertype = UserType.new(self)
    usertype.get_name
  end
end
