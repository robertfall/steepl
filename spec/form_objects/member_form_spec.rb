require 'spec_helper'

describe MemberForm do
  describe '#initialise' do
    context 'with valid parameters' do
      before :each do
        @params = {
          form: {
            first_name: 'Test',
            last_name: 'Guy',
            gender: 'Male',
            email: 'test@example.com',
            date_of_birth: "1988/01/01".to_date,
            joined_on: 1.year.ago.to_date,
            addresses_attributes: {
              '1' => {
                address1: 'Street Name',
                address2: 'Suburb Name',
                city: 'City Name',
                postal_code: 'P05741'
              },
              '2' => {
                address1: 'Street Name',
                address2: 'Suburb Name',
                city: 'City Name',
                postal_code: 'P05741'
              }
            },
            phone_numbers_attributes: {
              '1' => {
                dialing_code: '021',
                number: '4442233',
                mobile: false
              },
              '2' => {
                dialing_code: '072',
                number: '4442233',
                mobile: true
              }
            }
          }
        }
        @form = MemberForm.new(@params[:form])
      end

      it 'assigns scalar values' do
        @form.first_name.should eq 'Test'
        @form.last_name.should eq 'Guy'
        @form.gender.should eq 'Male'
        @form.email.should eq 'test@example.com'
        @form.date_of_birth.should eq "1988/01/01".to_date
        @form.joined_on.should eq 1.year.ago.to_date
      end

      it 'assigns phone numbers' do
        @form.phone_numbers.count.should eq 2
      end

      it 'assigns addresses' do
        @form.addresses.count.should eq 2
      end
    end
  end

  describe '#validate' do
    it 'validates scalars' do
      form = MemberForm.new({})
      form.should_not be_valid
      [:first_name, :gender, :last_name, :date_of_birth, :joined_on].each do |scalar|
        form.errors.should include(scalar)
      end
    end

    it 'validates addreses' do
      form = MemberForm.new({
        first_name: 'Test',
        last_name: 'Guy',
        gender: 'Male',
        email: 'test@example.com',
        date_of_birth: "1988/01/01".to_date,
        joined_on: 1.year.ago.to_date,
        addresses_attributes: {
          "1" => {}
        }
      })

      form.should_not be_valid
    end

    it 'validates phone numbers' do
      form = MemberForm.new({
        first_name: 'Test',
        last_name: 'Guy',
        gender: 'Male',
        email: 'test@example.com',
        date_of_birth: "1988/01/01".to_date,
        joined_on: 1.year.ago.to_date,
        phone_numbers_attributes: {
          "1" => {}
        }
      })

      form.should_not be_valid
    end
  end

  describe '#save' do
    before :each do
      @form = MemberForm.new
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
    before :each do
      @form_attributes = {
        id: 1,
        first_name: 'Test',
        last_name: 'Guy',
        gender: 'Male',
        email: 'test@example.com',
        date_of_birth: "1988/01/01".to_date,
        joined_on: 1.year.ago.to_date,
        addresses_attributes: {
          '1' => {
            name: 'Postal Address',
            address1: 'Street Name',
            address2: 'Suburb Name',
            city: 'City Name',
            postal_code: 'P05741'
          },
          '2' => {
            name: 'Street Address',
            address1: 'Street Name',
            address2: 'Suburb Name',
            city: 'City Name',
            postal_code: 'P05741'
          }
        },
        phone_numbers_attributes: {
          '1' => {
            name: 'Home Phone',
            dialing_code: '021',
            number: '4442233',
            mobile: false
          },
          '2' => {
            name: 'Cell Phone',
            dialing_code: '072',
            number: '4442233',
            mobile: true
          }
        }
      }

      @form = MemberForm.new(@form_attributes)
    end

    context 'with no existing records' do
      it 'creates a member' do
        -> {
          @form.persist!
        }.should change(Member, :count).by(1)
      end

      it 'creates nested addresses' do
        -> {
          @form.persist!
        }.should change(Address, :count).by(2)
      end

      it 'creates nested phone numbers' do
        -> {
          @form.persist!
        }.should change(PhoneNumber, :count).by(2)
      end
    end

    context 'with existing records' do
      it 'does not create a new member' do
        create(:member, id: 1)
        -> {
          @form.persist!
        }.should_not change(Member, :count)
      end

      it 'updates the member' do
        member = create(:member, first_name: 'old_name')
        @form.persist!
        member.reload.first_name.should eq 'Test'
      end

      it 'updates existing addresses' do
        address = create(:address, id: 1, address1: 'Old Street')
        form = MemberForm.new(@form_attributes)
        form.persist!
        address.reload.address1.should eq 'Street Name'
      end

      it 'creates new addresses' do
        address = create(:address, id: 4, address1: 'Old Street')
        form = MemberForm.new(@form_attributes)
        -> {
          form.persist!
        }.should change(Address, :count).by(2)
      end

      it 'updates existing phone numbers' do
        number = create(:cell_number, id:1, dialing_code:'074')
        form = MemberForm.new(@form_attributes)
        form.persist!
        number.reload.dialing_code.should eq '021'
      end

      it 'creates new phone numbers' do
        number = create(:cell_number, id:4)
        form = MemberForm.new(@form_attributes)
        -> {
          form.persist!
        }.should change(PhoneNumber, :count).by(2)
      end
    end
  end
end
