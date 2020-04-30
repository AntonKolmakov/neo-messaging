RSpec.describe Message, type: :model do
  let!(:patient) { create :user, :patient }
  let!(:doctor) { create :user, :doctor }
  let!(:admin) { create :user, :admin }

  let(:message) { create :message, { inbox: doctor.inbox, outbox: patient.outbox } }
  let(:expire_message) { create :message, :expired_message, { inbox: doctor.inbox, outbox: patient.outbox } }

  describe 'Patient send new message to a doctor' do
    it 'Should increments the unread messages counter' do
      expect{message}.to change{doctor.reload.inbox.unread_messages}.from(0).to(1)
    end

    describe '#incriment_unread_message!' do
      before do
        expire_message
        message
      end
      it 'Doctor inbox should have only reliable messages' do
        expect(doctor.reload.inbox.messages).to include(message)
      end

      it 'Should find all the expire messages and redirect to admin inbox' do
        expect(admin.reload.inbox.messages).to include(expire_message)
      end

      it 'Should decrement counter of expired messages in doctor inbox' do
        expect(doctor.reload.inbox.unread_messages).to eq(1)
      end
    end
  end
end