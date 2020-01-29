require 'rails_helper'

RSpec.describe Widget, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:kind) }
  end

  describe 'Relationships' do
    it { should belong_to(:user) }
  end
end
