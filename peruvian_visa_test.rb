require 'minitest/autorun'
require 'minitest/pride'
require 'active_support/all'
require 'pry'
require_relative 'peruvian_visa'

class TestPeruvianVisa < MiniTest::Test
  def test_days_since_entry_with_string
    visa = PeruvianVisa.new("yesterday")
    assert_equal 1, visa.days_since_entry
  end

  def test_days_since_entry_with_date
    visa = PeruvianVisa.new(Date.today.yesterday)
    assert_equal 1, visa.days_since_entry
  end

  def test_days_since_entry_with_time
    yesterday = Time.now.ago(24 * 60 * 60)
    visa = PeruvianVisa.new(yesterday)
    assert_equal 1, visa.days_since_entry
  end

  def test_display_time_since_entry
    visa = PeruvianVisa.new("yesterday")
    message = "1 day"
    assert_equal message, visa.display_time_since_entry
  end

  def test_days_left_positive
    visa = PeruvianVisa.new("yesterday", 3)
    assert_equal 2, visa.days_left
  end

  def test_days_left_negative
    entry_date = Time.now - 7
    visa = PeruvianVisa.new(entry_date, 5)
    binding.pry
    assert_equal (-2), visa.days_left
  end
end
