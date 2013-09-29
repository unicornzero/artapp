require 'spec_helper'
require 'rspec/expectations'

RSpec::Matchers.define :permit do |*args|
  match do |permission|
    permission.allow?(*args) == true
  end

 description do
    "have access to '#{args}'"
  end
end

describe Permission do
  describe '#allow?' do
    context 'guest' do
      subject { Permission.new(nil) }
      it { should permit("users", "index") }
      it { should_not permit("spaces", "edit") }
      it { should_not permit("photos", "edit") }
    end

    context 'user' do
      subject { Permission.new(build(:user)) }
      it { should permit("users", "index") }
      it { should_not permit("spaces", "edit") }
      it { should_not permit("photos", "edit") }

    end

    context 'superadmin' do
      subject { Permission.new(build(:user, superadmin: true)) }
      it { should permit("users", "index") }
      it { should permit("spaces", "edit") }
      it { should permit("photos", "edit") }
    end

    context 'space-owner' do
      let(:user) { create(:user) }
      let(:owned_space) { create(:space, user_id: user.id) }
      let(:other_space) { create(:space) }
      let(:owned_photo) { Photo.new(name: 'My image', 
                                    space_id: owned_space.id) }
      let(:other_photo) { Photo.new(name: 'My image', 
                                    space_id: other_space.id) }
      subject { Permission.new(user)}
      it { should permit("users", "index") }
      it { should permit("spaces", "edit", owned_space) }
      it { should_not permit("spaces", "edit", other_space) }
      it { should permit("photos", "edit", owned_photo) }
      it { should_not permit("photos", "edit", other_photo) }
      it { should permit("spaces", "update", owned_space) }
      it { should_not permit("spaces", "update", other_space) }
      it { should permit("photos", "update", owned_photo) }
      it { should_not permit("photos", "update", other_photo) }
    end

  end  
end