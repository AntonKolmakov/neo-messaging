class Message < ApplicationRecord
  belongs_to :inbox
  belongs_to :outbox

  validates :body, presence: true

  scope :inbox_doctor, -> { where("created_at >= ?", 1.week.ago) }
  scope :inbox_admin, -> { where("created_at <= ?", 1.week.ago) }
end