require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
      it { should have_many(:photos).class_name('Photo')}
      it { should have_many(:albums).class_name('Album')}
      it { should have_many(:likes).class_name('Like')}
      it { should have_many(:followings).class_name('User')}
      it { should have_many(:followers).class_name('User')}
    end
    describe 'validations' do
      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name)}
      it { should validate_presence_of(:email)}
      it { should validate_uniqueness_of(:first_name).scoped_to(:last_name)}
      it { should validate_length_of(:first_name).is_at_most(25)}
      it { should validate_length_of(:last_name).is_at_most(25)}
    end
end
