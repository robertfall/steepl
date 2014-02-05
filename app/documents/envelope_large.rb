class Documents::EnvelopeLarge < Prawn::Document
  include Prawn::Measurements
  attr_accessor :start_date, :members

  def initialize(params={})

    document_folder = "#{Rails.root}/app/documents/"
    @logo = document_folder + 'logo.png'

    @page_size = [mm2pt(162), mm2pt(229)]
    puts @page_size

    params[:skip_page_creation] = true
    params[:page_size] = @page_size
    params[:page_layout] = :landscape
    super params
  end

  def draw_fields
    @members.each do |member|
      start_new_page(page_size: @page_size)
      draw_logo
      draw_subtitle
      draw_number(member)
      draw_name(member)
      draw_address(member)
    end
  end

  def draw_logo
    bounding_box([37, 293], :width => 100, :height => 100) do
      image @logo, fit: [100, 100]
    end
  end

  def draw_subtitle
    bounding_box([14, 170], :width => 150, :height => 26) do
      font "Helvetica", style: :bold
      font_size 18
      text "TITHE & GIVING", align: :center
    end
  end

  def draw_number(member)
    bounding_box([14, 150], :width => 150, :height => 26) do
      font "Courier"
      font_size 18
      text "Member ##{sprintf '%03d', member.id}", align: :center
    end
  end

  def draw_name(member)
    bounding_box([180, 290], :width => 350, :height => 90) do
      font "Helvetica"
      font_size 36
      text member.full_name.upcase, valign: :center
    end
  end

  def draw_address(member)
    address = member.addresses.first
    bounding_box([180, 190], :width => 350, :height => 200) do
      font "Helvetica"
      font_size 20
      text address.to_s.upcase
    end
  end
end
