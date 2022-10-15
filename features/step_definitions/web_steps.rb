# frozen_string_literal: true

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'support', 'paths'))

module WithinHelpers
  def with_scope(locator, &block)
    if locator
      within(locator, match: :first, &block)
    else
      yield
    end
  end
end
World(WithinHelpers)

Given /^(?:|I )am on (.+)$/ do |page_name|
  navigate_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  navigate_to(page_name)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  confirm_on_page(page_name)
end

When /^(?:|I )press "([^"]*)"(?: within "([^"]*)")?$/ do |button, selector|
  with_scope(selector) do
    click_button(button)
  end
end

When /^(?:|I )follow "([^"]*)"(?: within "([^"]*)")?$/ do |link, selector|
  with_scope(selector) do
    click_link(link)
  end
end

When /^(?:|I )fill in "([^"]*)" (?:for|with) "([^"]*)"(?: within "([^"]*)")?$/ do |field, value, selector|
  with_scope(selector) do
    fill_in(field, with: value)
  end
end

Then /^(?:|I )should see (".+?"\s*)(?:\s+within\s* "([^"]*)")?$/ do |vars, selector|
  vars.scan(/"([^"]+?)"/).flatten.each do |text|
    with_scope(selector) do
      expect(current_scope).to have_content(text)
    end
  end
end

Then /^(?:|I )should see \/([^\/]*)\/(?: within "([^"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    expect(page).to have_xpath('//*', text: regexp)
  end
end

Then /^(?:|I )should not see (".+?"\s*)(?:\s+within\s* "([^"]*)")?$/ do |vars, selector|
  vars.scan(/"([^"]+?)"/).flatten.each do |text|
    with_scope(selector) do
      expect(page).to have_no_content(text)
    end
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/(?: within "([^"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    expect(page).to have_no_xpath('//*', text: regexp)
  end
end
