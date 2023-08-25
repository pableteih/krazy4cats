class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :publication

  validates :user, presence: true
end
