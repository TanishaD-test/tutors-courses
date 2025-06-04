require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should have_many(:tutors).dependent(:destroy) }
  it { should validate_presence_of(:name) }
end