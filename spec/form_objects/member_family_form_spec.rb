require 'spec_helper'

describe FamilyMemberForm do
  describe '#validate' do
    before :each do
      member = build(:member)
      @form = FamilyMemberForm.new(member: member)
    end
    it 'requires either a family id or a family name' do
      @form.should_not be_valid

      @form.family_name = 'Test'
      @form.should be_valid

      @form.family_name = nil
      @form.family_id = 1
      @form.should be_valid
    end
  end

  describe '#save' do
    before :each do
      @form = FamilyMemberForm.new
    end
    it 'validates the form' do
      @form.should_receive(:valid?)
      @form.save
    end

    context 'when valid' do
      it 'persists the form' do
        @form.stub(:valid?).and_return(true)
        @form.should_receive(:persist!)
        @form.save
      end
    end

    context 'when invalid' do
      it 'does not persist the form' do
        @form.stub(:valid?).and_return(false)
        @form.should_not_receive(:persist!)
        @form.save
      end
    end
  end

  describe '#persist!' do
    context 'when no family exists' do
      before :each do
        member = create(:member)
        @form = FamilyMemberForm.new(family_name: 'Test',
                                     member: member)
      end

      it 'creates a family' do
        -> {
          @form.persist!
        }.should change(Family, :count).by(1)
      end

      it 'creates a family relation' do
        -> {
          @form.persist!
        }.should change(FamilyMember, :count).by(1)
      end
    end

    context 'when a family exists' do
      before :each do
        member = create(:member)
        @family = create(:family)
        @form = FamilyMemberForm.new(family_id: @family.id,
                                     member: member)
      end
      it 'does not create a family' do
        -> {
          @form.persist!
        }.should_not change(Family, :count)
      end

      it 'creates a family relation' do
        @form.persist!
        @family.reload.family_members.count.should eq 1
      end
    end

  end
end
