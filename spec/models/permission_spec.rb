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
      let(:space) { create(:space) }
      it { should permit("users", "index") }
      it { should permit("spaces", "index") }
      it { should permit("spaces", "show") }
      it { should permit("photos", "show") }
      it { should permit("spaces", "show", space) }
      it { should_not permit("spaces", "edit") }
      it { should_not permit("photos", "edit") }
      it { should_not permit("users", "show") }
    end

    context 'user' do
      subject { Permission.new(build(:user)) }
      let(:space) { create(:space) }
      it { should permit("users", "index") }
      it { should permit("spaces", "index") }
      it { should permit("photos", "show") }
      it { should permit("users", "show") }
      it { should permit("spaces", "show", space) }
      it { should_not permit("spaces", "edit") }
      it { should_not permit("photos", "edit") }
    end

    context 'superadmin' do
      subject { Permission.new(build(:user, superadmin: true)) }
      let(:space) { create(:space) }
      it { should permit("users", "index") }
      it { should permit("users", "show") }
      it { should permit("spaces", "index") }
      it { should permit("spaces", "show", space) }
      it { should permit("spaces", "edit") }
      it { should permit("photos", "show") }
      it { should permit("photos", "create") }
      it { should permit("photos", "edit") }
      it { should permit("photos", "update") }
      it { should permit("photos", "destroy") }
    end

    context 'space-owner' do
      let(:user) { create(:user) }
      let(:owned_space) { create(:space, user_id: user.id) }
      let(:other_space) { create(:space) }
      let(:owned_subscription) { Subscription.new(space_id: owned_space.id,
                                user_id: user.id) }
      subject { Permission.new(user)}
      it { should permit("users", "index") }
      it { should permit("users", "show") }
      it { should permit("spaces", "index") }
      it { should permit("spaces", "show", other_space) }
      it { should permit("spaces", "edit", owned_space) }
      it { should permit("spaces", "update", owned_space) }
      it { should_not permit("spaces", "edit", other_space) }
      it { should_not permit("spaces", "update", other_space) }

      it { should permit("photos", "show") }
      it { should permit("photos", "create", owned_space) }
      it { should permit("photos", "edit", owned_space) }
      it { should permit("photos", "update", owned_space) }
      it { should permit("photos", "destroy", owned_space) }
      it { should_not permit("photos", "edit", other_space) }
      it { should_not permit("photos", "update", other_space) }
      it { should_not permit("photos", "destroy", other_space) }

      it { should permit("subscriptions", "edit", owned_subscription) }
      it { should permit("subscriptions", "update", owned_subscription) }
    end
  end  
end