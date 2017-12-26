class User < ApplicationRecord
  belongs_to :identifiable, polymorphic: true
  validates_uniqueness_of :username
  has_secure_password
end
