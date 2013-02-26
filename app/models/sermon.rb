# == Schema Information
#
# Table name: sermons
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  series     :string(255)
#  preacher   :string(255)
#  date       :date
#  duration   :integer
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sermon < ActiveRecord::Base
  attr_accessible :date, :duration, :name, :preacher, :series, :url
  validates_presence_of :name, :date, :preacher, :url

  scope :for_year, lambda {|year| where("date >= ? and date <= ?", "#{year}-01-01", "#{year}-12-31")}

  def self.create_from_params(params)
    # 2012-12-31 Rev Alan Molyneux - This is my sermon.mp3
    filename = params[:filename]
    sermon = Sermon.new
    sermon.date = filename.slice!(0..9)
    properties = filename.strip.split(' - ')

    sermon.preacher = properties.shift
    sermon.series = properties.shift if properties.count > 1
    real_name = properties.shift
    sermon.name = File.basename(real_name, File.extname(real_name))

    sermon.duration = params[:duration] if params[:duration]
    sermon.url = params[:url]
    sermon
  end

  def increment_play_count!
    update_column(:play_count, play_count + 1)
  end
end
