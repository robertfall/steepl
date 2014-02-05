class Documents::EnvelopeSmall < Prawn::Document
  include Prawn::Measurements
  attr_accessor :start_date, :members

  def initialize(params={})

    document_folder = "#{Rails.root}/app/documents/"
    @logo = document_folder + 'logo.png'

    @page_size = [mm2pt(90), mm2pt(150)]
    puts @page_size

    params[:skip_page_creation] = true
    params[:page_size] = @page_size
    params[:page_layout] = :landscape
    @start_date = Time.zone.today
    super params
  end

  def draw_fields
    @members.each do |member|
      (0..5).each do |index|
        month = @start_date + index.months
        start_new_page(page_size: @page_size)
        font "Helvetica"
        draw_logo
        draw_title
        draw_paragraph
        draw_description
        draw_bank_details
        draw_bank_notice
        draw_month(month)
        draw_number(member)
      end
    end
  end

  def draw_logo
    bounding_box([-7, 180], :width => 75, :height => 75) do
      image @logo, fit: [75, 75]
    end
  end

  def draw_title
    bounding_box([78, 180], :width => 250, :height => 27) do
      font_size 28
      text "TITHE & GIVING"
    end
  end

  def draw_paragraph
    bounding_box([78, 145], :width => 280, :height => 50) do
      font "Helvetica"
      font_size 9
      text "The gospel makes us generous (2 Cor 8:9) and unafraid to part with our material possessions. As people of faith, we are to give faithfully and joyfully; and we want you to be a part of that. Your gift will not only support the ministries of TVMC, but it will also help to fund a variety of resources."
    end
  end

  def draw_description
    bounding_box([242, 80], :width => 120, :height => 10) do
      font_size 9
      font "Helvetica", style: :bold
      text "Should you wish to EFT", align: :left
    end
  end

  def draw_bank_details
    bounding_box([242, 65], :width => 120, :height => 70) do
      font_size 9
      font "Helvetica"
      text "Bank: First National Bank\nAccount: 5923 000 5827\nBranch: Table View\nBranch code: 203 809", align: :left
    end
    stroke { line [232, 80], [232, 0] }
  end

  def draw_bank_notice
    bounding_box([242, 17], :width => 120, :height => 25) do
      font_size 9
      font "Helvetica", style: :bold
      text "Please use member number as reference.", align: :left
    end
  end

  def draw_month(month)
    bounding_box([-7, 60], :width => 240, :height => 37) do
      font "Helvetica"
      font_size 36
      text month.strftime("%B").upcase, align: :left
    end
  end

  def draw_number(member)
    bounding_box([-7, 30], :width => 240, :height => 16) do
      font "Courier"
      font_size 14
      text "Member ##{sprintf '%03d', member.id}", align: :left
    end
  end
end
