class Widget < ApplicationRecord
  validates :name, :description, :kind, presence: true
  belongs_to :user
end
