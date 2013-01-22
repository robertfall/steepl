class Sermon < ActiveRecord::Base
  attr_accessible :date, :duration, :name, :preacher, :series, :url
  validates_presence_of :name, :date, :preacher, :url

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
end
