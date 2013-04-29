class MemberFilterForm

  include ActiveModel::Model
  attr_accessor :query, :age_min, :age_max, :age_min_limit, :age_max_limit,
    :birthday_min, :birthday_max, :genders, :relationship_statuses,
    :employment_statuses, :preferred_services

  def initialize(params={})
    members = Member.where('date_of_birth IS NOT NULL').order(:date_of_birth)
    @age_min_limit = members.last.age
    @age_max_limit = members.first.age
    @age_min = @age_min_limit
    @age_max = @age_max_limit
    super
  end

  def results
    @results ||= search.results
  end

  def facet_includes?(facet, term)
    local = send(facet)
    local and local.include?(term)
  end

  def search
    Tire.search 'members', size: 1000 do |search|
      search.query { |query|  query.string self.query } if query.present?

      search.filter :range,
        'birthday' => { gte: birthday_min_int, lte: birthday_max_int } if filter_birthday?
      search.filter :range,
        'age' => { gte: age_min, lte: age_max } if filter_age?
      search.filter :terms,
        'gender' => @genders.split(', ') if @genders.present?
      search.filter :terms,
        'employment_status' => @employment_statuses.split(', ') if @employment_statuses.present?
      search.filter :terms,
        'relationship_status' => @relationship_statuses.split(', ') if @relationship_statuses.present?
      search.filter :terms,
        'preferred_service' => @preferred_services.split(', ') if @preferred_services.present?

      search.sort { by :sort_name, 'asc' }

      search.facet('genders', global: true) {  terms :gender }
      search.facet('relationship_statuses', global: true) {  terms :relationship_status }
      search.facet('employment_statuses', global: true) {  terms :employment_status }
      search.facet('preferred_services', global: true) {  terms :preferred_service }
    end
  end

  private
  def birthday_min_int
    birthday_min.present? && birthday_min.to_date.strftime('%m%d').to_i
  end

  def birthday_max_int
    birthday_max.present? && birthday_max.to_date.strftime('%m%d').to_i
  end

  def filter_birthday?
    birthday_min_int and birthday_max_int
  end

  def filter_age?
    (age_min.present? and age_min != age_min_limit) and (age_max.present? and age_max != age_max_limit)
  end
end
