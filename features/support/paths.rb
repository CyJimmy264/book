# frozen_string_literal: true

module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /^the profile page$/
      user_path(@current_user)
    when /^the ([\w ]+) page$/
      public_send("#{Regexp.last_match(1).gsub(/\W+/, '_')}_path")
    when /^"(\/.*)"/
      Regexp.last_match(1)
    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end

  def navigate_to(page_name)
    path = path_to(page_name)
    if path.is_a?(Hash)
      visit(path[:path])
      await_elem = path[:special_elem]
      find(await_elem.delete(:selector), await_elem)
    else
      visit(path)
    end
  end

  def confirm_on_page(page_name)
    expect(page).to have_current_path(path_to(page_name))
  end
end

World(NavigationHelpers)
