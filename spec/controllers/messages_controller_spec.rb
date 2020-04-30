RSpec.describe MessagesController, type: :controller do
  let!(:patient) { create :user, :patient }
  let!(:doctor) { create :user, :doctor }
  let!(:admin) { create :user, :admin }

  describe '#create' do
    let!(:expired_message) { create :message, :expired_message, inbox: doctor.inbox, outbox: patient.outbox }

    before do
      post :create, params: { message: { body: 'Hello doctor...' } }
    end

    describe 'Patient send new message to the doctor' do
      it 'Doctor receive message with unread status' do
        expect(doctor.reload.inbox.messages.first.read).to be_falsy
      end

      it 'the number of unread messages is incremented' do
        expect(doctor.reload.inbox.unread_messages).to eq(1)
      end

      context 'The original message was created in the past week' do
        it 'The message appear in the doctor’s inbox' do
          expect(doctor.reload.inbox.messages).not_to include(expired_message)
        end
      end

      context 'The original message was created more than a week ago' do
        it 'The message is in the admin’s inbox' do
          expect(admin.reload.inbox.messages).to include(expired_message)
        end
      end
    end
  end

  describe '#show' do
    let!(:message_to_doctor) { create :message, inbox: doctor.inbox, outbox: patient.outbox }

    before { get :show, params: { id: message_to_doctor.id } }

    describe 'When the doctor read message' do
      it 'the number of unread messages is decremented' do
        expect(doctor.reload.inbox.unread_messages).to eq(0)
      end
    end
  end
end