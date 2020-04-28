RSpec.describe User, type: :model do
  subject(:user) { build :user }

  describe 'full name' do
    it ' eq to first name + last name' do
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
  end
end