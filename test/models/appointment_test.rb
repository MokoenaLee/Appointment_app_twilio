require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase


  test 'valid user' do
    user = Appointment.new(name: "Sarah", phone_number: 7489365740, time:"2020-05-24 18:30:00 UTC")
    assert user.save

  end

  test 'only numeric values in phone number' do
    user = Appointment.new(name: "Sarah", phone_number: "Sar", time:"2020-05-24 18:30:00 UTC")
    assert_false user.valid?

  end

  test 'invalid without a name' do
    user = Appointment.new(phone_number: "7846378990")
    refute user.valid?
    assert_not_nil user.errors[:name], 'no validation error for name present'

  end

  test 'invalid without a phone number' do
    user = Appointment.new(name: "Mandla")
    refute user.valid?
    assert_not_nil user.errors[:phone_number], 'no validation error for name present'

  end
end
