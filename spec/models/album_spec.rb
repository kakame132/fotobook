require 'rails_helper'

RSpec.describe Album, type: :model do
  describe 'associations' do
      it { should belong_to(:user).class_name('User')}
      it { should have_many(:photos).class_name('Photo')}
      it { should have_many(:likes).class_name('Like')}
    end
    describe 'validations' do
      it { should validate_presence_of(:title)}
      it { should validate_length_of(:title).is_at_least(10)}
      it { should validate_length_of(:title).is_at_most(140)}
      it { should validate_length_of(:description).is_at_most(300)}
    end
end
