class PaymentService
  AMOUNT = 10

  def initialize(user)
    @sender = user
  end

  def call
      res = charge_payment
      send_message_to_admin
      res
    rescue PaymentProvider::Error => e
      { error: e.message }
  end

  private

  attr_reader :sender

  def send_message_to_admin
    Message.create(
      body: I18n.t('request_message', full_name: sender.full_name),
      outbox: sender.outbox,
      inbox: User.default_admin.inbox
    )
  end

  def charge_payment
    response = PaymentProvider::Authenticator.call(sender)
    sender.payments.create!(amount: AMOUNT)
    response
  end
end