require 'spec_helper'

describe Space do

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should_not allow_value("a" * 51).for(:name) }
  it { should have_many(:albums) }
  it { should have_many(:photos).through(:albums) }

  it 'should be valid with valid information' do
    space = build(:space)

    expect(space).to be_valid
  end

  it 'should create album when space is created' do
    space = Space.create(name: "My Art Museum")
    expect(space.albums.count).to eq(1)
  end

  it 'should delete associated albums when deleted'
end
