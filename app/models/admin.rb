class Admin < ApplicationRecord
  has_one :user, as: :identifiable
end
