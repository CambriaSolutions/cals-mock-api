require 'rails_helper'

RSpec.describe Facility, type: :model do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:number) }
end
