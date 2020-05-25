class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  validates :name, presence: true
  validates :phone_number,presence: true
  #numericality => {:only_integer => true}
  validates :time, presence: true

  after_create :reminder

  def reminder
    @twilio_number =  ENV['TWILIO_NUMBER']
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    @client = Twilio::REST::Client.new account_sid, ENV['TWILIO_AUTH_TOKEN']
    time_str = ((self.time).local.time).strftime("%I:%M%p on %b. %d, %Y")
    body = "Hi #{self.name}. Just a reminder that you have an appointment coming up at #{time_str}."
    message = @client.messages.create(
      :from => @twilio_number,
      :to => self.phone_number,
      :body => body,
    )
  end

  def when_to_run
    minutes_before_appointment = 30.minutes
    time - minutes_before_appointment
  end

  handle_asynchronously :reminder, :run_at => Proc.new{|i| i.when_to_run}

end
#note the script is to be run continously and there needs to be a script that will check the database for the upcoming appointment(s)
