RSpec.describe PaymentController, type: :controller do
  let!(:patient) { create :user, :patient }
  let!(:admin) { create :user, :admin }

  describe '#create' do
    before { post :create }

    it 'creates a payment from payment provider for charge succeeded' do
      expect(Payment.count).to eq(1)
    end

    it 'creates the payment with the amount' do
      expect(Payment.first.amount).to eq(10)
    end

    it 'creates admin inbox message' do
      expect(admin.reload.inbox.messages.count).to eq(1)
    end

    it 'success flash message is appears' do
      expect(flash[:success]).to be_present
    end
  end

  describe 'When the Payment API fails for some reason' do
    before do
      allow_any_instance_of(PaymentProvider::Authenticator).to receive(:response)
                                                            .and_return({ code: 401, msg: 'invalid card' })
    end

    it 'Dont do creates any payments and messages' do
      post :create
      expect(admin.reload.inbox.messages.count).to eq(0)
      expect(Payment.all).to eq([])
    end

    it 'error flash message is appears' do
      post :create
      expect(flash[:danger]).to be_present
    end
  end
end