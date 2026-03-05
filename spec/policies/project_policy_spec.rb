# spec/policies/project_policy_spec.rb
require 'rails_helper'

RSpec.describe ProjectPolicy do
  subject { described_class.new(user, project) }

  before do
    Project.destroy_all  # 👈 ensure no leftover projects
  end

  let(:project) { create(:project) }

  # Test each role
  context 'for a viewer' do
    let(:user) { create(:user, role: :viewer) }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'for an editor' do
    let(:user) { create(:user, role: :editor) }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'for an admin' do
    let(:user) { create(:user, role: :admin) }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:destroy) }
  end

  describe 'Scope' do
    subject { ProjectPolicy::Scope.new(user, Project.all).resolve }

    let!(:project1) { create(:project) }
    let!(:project2) { create(:project) }

    context 'for a viewer' do
      let(:user) { create(:user, role: :viewer) }
      it 'returns no projects' do
        expect(subject).to be_empty
      end
    end

    context 'for an editor' do
      let(:user) { create(:user, role: :editor) }
      it 'returns no projects' do
        expect(subject).to be_empty
      end
    end

    context 'for an admin' do
      let(:user) { create(:user, role: :admin) }
      it 'returns all projects' do
        expect(subject).to contain_exactly(project1, project2)
      end
    end

    context 'with no user (nil)' do
      let(:user) { nil }
      it 'returns no projects' do
        expect(subject).to be_empty
      end
    end
  end
end