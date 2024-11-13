module BooksHelper
  def highlight_text(text, query)
    return text unless query.present?

    # Escape the query string for regex
    escaped_query = Regexp.escape(query)

    text.gsub(/(#{escaped_query})/i) { |match| "<strong>#{match}</strong>" }.html_safe
  end
end
