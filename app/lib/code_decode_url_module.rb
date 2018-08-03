module CodeDecodeUrlModule

  # Total charecter to encode base to str
  @@total_char = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  @@total_char_hash = Hash[@@total_char.chars.map.with_index.to_a]
  @@rand_str_len = 1

  # It will convert id to base 62 and assign char from
  # @@total char and add rand str
  def genrate_short_url(url_id)
    rand_str = get_rand_str
    shorturl = Array.new
    while url_id != 0
      char_index = (url_id%62).to_i
      shorturl.push(@@total_char[char_index])
      url_id = url_id/62
    end
    base_str = shorturl.reverse!.join
    rand_str+base_str
  end

  #method to get random char
  def get_rand_str
    SecureRandom.hex(@@rand_str_len)
  end

  #method to get base url
  def get_base_url
    request.base_url
  end

  #method to remove random str from url code
  def get_decoded_url
    request.original_fullpath.slice!(3..-1)
  end

  #method to deocde in base 10
  def get_url_id(decoded_url)
    decoded_url.reverse!
    url_id = 0
    decoded_url.each_char.with_index do |char, i|
      url_id += @@total_char_hash[char].to_i* (62 ** i)
    end
    url_id
  end
end
