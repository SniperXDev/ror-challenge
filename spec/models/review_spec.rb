require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:book) }
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:content) }
end
