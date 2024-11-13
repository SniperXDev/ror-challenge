require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should have_many(:reviews).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
end
