module ApplicationHelper
  def simple_hash_format(hash)
    string = ""

    hash.each_pair do |key, value|
      string << sanitize("#{key}: #{ value }", tags: [], attributes: [])
      string << "</br>"
    end

    string.html_safe
  end
end
