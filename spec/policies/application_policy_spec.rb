# spec/policies/application_policy_spec.rb
require 'rails_helper'

RSpec.describe ApplicationPolicy do
  subject { described_class.new(user, record) }

  let(:user) { User.new }
  let(:record) { Object.new } # a dummy record

  describe '#initialize' do
    it 'sets user and record' do
      expect(subject.user).to eq(user)
      expect(subject.record).to eq(record)
    end
  end

  # All base methods should return false by default
  describe '#index?' do
    it { expect(subject.index?).to be false }
  end

  describe '#show?' do
    it { expect(subject.show?).to be false }
  end

  describe '#create?' do
    it { expect(subject.create?).to be false }
  end

  describe '#new?' do
    it 'aliases create?' do
      expect(subject.new?).to eq(subject.create?)
    end
  end

  describe '#update?' do
    it { expect(subject.update?).to be false }
  end

  describe '#edit?' do
    it 'aliases update?' do
      expect(subject.edit?).to eq(subject.update?)
    end
  end

  describe '#destroy?' do
    it { expect(subject.destroy?).to be false }
  end

  describe ApplicationPolicy::Scope do
    subject { described_class.new(user, scope) }

    let(:scope) { double('Scope') }
    let(:user) { User.new }

    describe '#initialize' do
      it 'sets user and scope' do
        expect(subject.send(:user)).to eq(user)
      expect(subject.send(:scope)).to eq(scope)
      end
    end

    describe '#resolve' do
      it 'raises NoMethodError' do
        expect { subject.resolve }.to raise_error(NoMethodError, /You must define #resolve in/)
      end
    end
  end
end