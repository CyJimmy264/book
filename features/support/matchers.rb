# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :have_true_js_value do |expected|
  match do |actual|
    await_condition { (actual.evaluate_script("#{expected}") == true) rescue false }
  end

  failure_message do
    "expected #{expected.inspect} in Javascript to be 'true' but it did not"
  end

  failure_message_when_negated do
    "expected #{expected.inspect} in Javascript not to be 'true' but it did"
  end
end

RSpec::Matchers.define :have_value do |expected|
  match do |actual|
    await_condition { actual.value && actual.value.include?(expected) rescue false }
  end

  failure_message do |actual|
    "expected #{actual.inspect} to have value #{expected.inspect} but was #{actual.value.inspect}"
  end
  failure_message_when_negated do |actual|
    "expected #{actual.inspect} to not have value #{expected.inspect} but it had"
  end
end

def await_condition(&condition)
  start_time = Time.zone.now
  until condition.call
    return false if (Time.zone.now - start_time) > Capybara.default_max_wait_time

    sleep 0.01
  end
  true
end
