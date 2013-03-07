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
            addresses: {
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
            phone_numbers: {
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
end
