class User < ApplicationRecord
  belongs_to :identifiable, polymorphic: true
  validates_uniqueness_of :username
  has_secure_password

  def get_proper_name
    new_user_type = UserType.new(self)
    new_user_type.get_name
  end
end
