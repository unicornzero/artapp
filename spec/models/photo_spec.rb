require 'spec_helper'

describe Photo do

  it { should belong_to(:album) }
  it { should validate_presence_of(:album_id) }
  it { should allow_value("My Photo Name").for(:name) }

end