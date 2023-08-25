class Publication < ApplicationRecord
  belongs_to :user
  has_many :reactions, dependent: :destroy
  has_many :users, through: :reactions
  has_many :comments, dependent: :destroy

  def count_with_kind(arg)
      number = self.reactions.where(kind: arg).count
      return "#{arg} - #{number}"
  end
  def find_kind_user_relation(user)
      self.reactions.find_by(user_id: user.id).kind
  end
end
