# frozen_string_literal: true

module Web::AdminHelper
  def active_link_to(name, path)
    link_to name, path, class: "#{'active' if current_page?(path)} nav-link link-dark"
  end
end
