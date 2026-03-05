# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Devise modules' do
    it 'includes invitable' do
      expect(User.devise_modules).to include(:invitable)
    end

    it 'includes database_authenticatable' do
      expect(User.devise_modules).to include(:database_authenticatable)
    end

    it 'includes registerable' do
      expect(User.devise_modules).to include(:registerable)
    end

    it 'includes recoverable' do
      expect(User.devise_modules).to include(:recoverable)
    end

    it 'includes rememberable' do
      expect(User.devise_modules).to include(:rememberable)
    end

    it 'includes validatable' do
      expect(User.devise_modules).to include(:validatable)
    end
  end

  describe 'validations' do
    subject { build(:user) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'requires an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'requires a unique email' do
      create(:user, email: 'test@example.com')
      duplicate = build(:user, email: 'test@example.com')
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:email]).to include('has already been taken')
    end

    it 'requires a valid email format' do
      user = build(:user, email: 'invalid')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('is invalid')
    end

    it 'requires a password on create' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'requires password confirmation to match' do
      user = build(:user, password: 'password', password_confirmation: 'different')
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

  describe 'enum role' do
    it 'defines a role enum with expected values' do
      expect(User.roles).to eq({ 'viewer' => 0, 'editor' => 1, 'admin' => 2 })
    end

    it 'has a default role of viewer' do
      user = User.new
      expect(user.role).to eq('viewer')
      expect(user.viewer?).to be true
    end

    it 'can be assigned an editor role' do
      user = build(:user, role: :editor)
      expect(user.editor?).to be true
    end

    it 'can be assigned an admin role' do
      user = build(:user, role: :admin)
      expect(user.admin?).to be true
    end

    it 'provides predicate methods for each role' do
      user = User.new(role: :editor)
      expect(user.editor?).to be true
      expect(user.viewer?).to be false
      expect(user.admin?).to be false
    end
  end

  describe 'factory' do
    it 'has a valid default factory' do
      expect(build(:user)).to be_valid
    end

    it 'generates unique emails via sequence' do
      user1 = create(:user)
      user2 = create(:user)
      expect(user1.email).not_to eq(user2.email)
    end

    describe 'traits' do
      it 'creates an editor user' do
        user = build(:user, :editor)
        expect(user.editor?).to be true
      end

      it 'creates an admin user' do
        user = build(:user, :admin)
        expect(user.admin?).to be true
      end
    end
  end
end