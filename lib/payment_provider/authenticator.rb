
module PaymentProvider
  class Authenticator < DryService
    def initialize(sender)
      @sender = sender
    end

    def call
      raise(PaymentProvider::Error, response[:msg]) unless response[:code] == 200

      response
    end

    private

    def response
      { code: 200, success: true }
    end
  end
end
