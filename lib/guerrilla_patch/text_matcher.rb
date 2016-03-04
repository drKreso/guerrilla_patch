class TextMatcher

  def self.match(source, target)
    result = {}
    source.each_pair { |key,value| source[key] = value.gsub(' ', '').downcase }
    target.each_pair { |key,value| target[key] = value.gsub(' ', '').downcase }

    target.each_pair do |target_key, target_value|
      result[target_key] = []
      temp_key_buffer = []
      temp_string_buffer = ""

      source.each_pair.map do |source_key, source_value|
        temp_key_buffer << source_key
        temp_string_buffer += source_value

        if temp_string_buffer == target_value
          result[target_key] = temp_key_buffer
          temp_key_buffer.each do |temp_buffer_key|
            source.delete(temp_buffer_key)
          end
          break
        elsif temp_string_buffer.start_with?(target_value)
          temp_key_buffer << source_key
          target[target_key] = target[target_key][(source[source_key].size+1)..-1] || ''
        elsif source_value.end_with?(target_value)
          result[target_key] = temp_key_buffer
          temp_key_buffer = []
          temp_string_buffer = ""
        end

      end
    end

    result
  end

end
