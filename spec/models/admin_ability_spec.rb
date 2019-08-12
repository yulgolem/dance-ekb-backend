require "cancan/matchers"

def prepare_admin
  let(:admin) { admin }
  subject(:ability) { AdminAbility.new(admin: admin) }
end

# TODO: make roles more isolated
# e.g. :can_manage_roles cannot edit basic admin data end create/delete admins

# TODO: make tests more precise
# i.e. not to describe what current role can but rather what cannot

describe Admin do
  # context 'when with :can_manage_roles' do
  #   let(:admin) { create :admin, :can_manage_roles }
  #   subject(:ability) { AdminAbility.new(admin: admin) }
  #
  #   it 'can manage user roles' do
  #     is_expected.to be_able_to(:manage, Admin.new)
  #   end
  # end
end
