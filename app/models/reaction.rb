class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :publication
  validates :kind, acceptance: { accept: %w[like dislike funny angry],}

    def self.kinds
      %w[like dislike funny angry]
    end
  end


