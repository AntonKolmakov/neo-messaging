class Message < ApplicationRecord
  belongs_to :inbox
  belongs_to :outbox

  validates :body, presence: true

  scope :find_expire_messages, -> { where("created_at <= ?", 1.week.ago) }

  after_create :incriment_unread_message!

  def mark_as_read!
    update!(read: true)
    decrement_read_message!
  end

  protected

  def decrement_read_message!
    inbox.decrement!(:unread_messages) if inbox.unread_messages > 0
  end

  private

  def incriment_unread_message!
    inbox.increment!(:unread_messages)

    redirect_messages
  end

  def redirect_messages
    Message.find_expire_messages.each do |message|
      message.decrement_read_message!
      message.update(inbox_id: User.default_admin.id)
    end
  end
end