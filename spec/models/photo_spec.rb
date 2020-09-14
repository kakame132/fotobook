require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe 'associations' do
      it { should belong_to(:user).class_name('User')}
      it { should belong_to(:album).optional}
      it { should have_many(:likes).class_name('Like')}
    end
    describe 'validations' do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:description)}
      it { should validate_length_of(:title).is_at_most(140)}
      it { should validate_length_of(:description).is_at_most(300)}
    end
end
