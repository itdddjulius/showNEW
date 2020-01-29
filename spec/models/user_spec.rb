require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation).on(:create) }
  end

  describe 'Users can be created' do
    it 'can create a regular user' do
      attributes = {
        first_name: 'Lois',
        last_name: 'Einhorn',
        email: 'imlois@einhorn.com',
        password: 'rayfinkle',
        password_confirmation: 'rayfinkle'
      }

      user = User.create(attributes)
      expect(user.first_name).to eq('Lois')
      expect(user.last_name).to eq('Einhorn')
      expect(user.email).to eq('imlois@einhorn.com')
      expect(user.password).to eq('rayfinkle')
    end

    it 'can create an admin user' do
      attributes = {
        first_name: 'Ray',
        last_name: 'Finkle',
        email: 'imray@finkle.com',
        password: 'loiseinhorn',
        password_confirmation: 'loiseinhorn'
      }

      user = User.create(attributes)
      expect(user.first_name).to eq('Ray')
      expect(user.last_name).to eq('Finkle')
      expect(user.email).to eq('imray@finkle.com')
      expect(user.password).to eq('loiseinhorn')
    end
  end
end
