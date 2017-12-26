class User < ApplicationRecord
  belongs_to :identifiable, polymorphic: true
end
