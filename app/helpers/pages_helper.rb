module PagesHelper
  def active?(path)
    return "is-active" if current_page?(path)
    ""
  end

  def active_tab(name, path)
    "<li class=#{active?(path)}>#{link_to(name, path)}</li>"
  end
end
