require 'spec_helper'

describe Album do
  
  it { should belong_to(:space) }
  it { should validate_presence_of(:space_id) }
  it { should have_many(:photos) }
  it { should allow_value("My Album Name").for(:name) }
  it { should_not allow_value("a" * 201).for(:name) }

  it 'should delete associated albums when deleted'

 end