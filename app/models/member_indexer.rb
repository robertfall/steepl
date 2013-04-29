class MemberIndexer
  def initialize(member)
    @member = member
  end

  def attributes
    {
      id: @member.id,
      full_name: @member.full_name,
      email: @member.email,
      age: @member.age,
      date_of_birth: @member.date_of_birth,
      birthday: birthday_int,
      phone_numbers: @member.phone_numbers.map{ |n| n.full },
      addresses: @member.addresses.map { |n| n.to_s },
      preferred_service: @member.preferred_service,
      gender: @member.gender,
      relationship_status: @member.relationship_status,
      employment_status: @member.employment_status,
      type: 'member'
    }
  end

  def type
    'member'
  end

  def to_indexed_json
    attributes.to_json
  end

  def birthday_int
    @member.date_of_birth && @member.date_of_birth.strftime("%m%d").to_i
  end

  def store
    Tire.index 'members' do |index|
      index.store attributes
      index.refresh
    end
  end

  def destroy
    Tire.index 'members' do |index|
      index.remove attributes
    end
  end

  def self.create_index
    Tire.index 'members' do
      delete
      create mappings: {
        member: {
          properties: {
            id: { type: 'integer' },
            full_name: { type: 'multi_field', fields: {
              full_name: { type: 'string', boost: 5 },
              sort_name: { type: 'string', index: 'not_analyzed' }
            }},
            email: {type: 'string' },
            age: { type: 'integer' },
            date_of_birth: { type: 'date' },
            birthday: { type: 'integer' },
            phone_numbers: { type: 'string' },
            addresses: { type: 'string' },
            preferred_service: { type: 'string', analyzer: 'keyword' },
            gender: { type: 'string', analyzer: 'keyword' },
            relationship_status: { type: 'string', analyzer: 'keyword' },
            employment_status: { type: 'string', analyzer: 'keyword' }
          }
        }
      }
    end
  end

  def self.refresh_index
    Tire.index 'members' do
      Member.find_in_batches(include: [:phone_numbers, :addresses]) do |members|
        import members.map { |m| MemberIndexer.new(m).attributes }
      end
    end
  end

  def self.reset_index
    create_index
    refresh_index
  end
end
