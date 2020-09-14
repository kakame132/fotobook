require 'rails_helper'

RSpec.describe Like, type: :model do
  it { should belong_to(:user).class_name('User')}
  it { should belong_to(:likeable)}
end
