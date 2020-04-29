RSpec.describe MessagesController, type: :controller do
  describe '#create' do
    let!(:patient) { create :user, :patient }
    let!(:doctor) { create :user, :doctor }
    let!(:admin) { create :user, :admin }
    let!(:expired_message) { create :message, :expired_message }

    before do
      post :create, params: { message: { body: 'Hello doctor...' } }
    end

    describe 'Patient send new message to the doctor' do
      it 'Doctor receive message with unread status' do
        expect(Message.inbox_doctor.first.read).to be_falsy
      end
    end

    context 'The original message was created in the past week' do
      it 'The message is in the doctor’s inbox' do
        expect(Message.inbox_doctor).not_to include(expired_message)
      end
    end

    context 'The original message was created more than a week ago' do
      it 'The message is in the admin’s inbox' do
        expect(Message.inbox_admin).to include(expired_message)
      end
    end
  end
end