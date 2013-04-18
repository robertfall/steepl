class MemberIndexer
  def initialize(member)
    @member = member
  end

  def attributes
    {
      id: @member.id,
      name: @member.full_name,
      age: @member.age,
      birthday: @member.birthday,
      type: 'member'
    }
  end

  def type
    'member'
  end

  def to_indexed_json
    attributes.to_json
  end

  def self.create_index
    Tire.index 'members' do
      delete
      create mappings: {
        member: {
          properties: {
            id: { type: 'integer' },
            name: { type: 'string', boost: 5 },
            age: { type: 'integer' },
            birthday: { type: 'date' }
          }
        }
      }
    end
  end

  def self.refresh_index
    Tire.index 'members' do
      Member.find_in_batches do |members|
        import members.map { |m| MemberIndexer.new(m).attributes }
      end
    end
  end
end
