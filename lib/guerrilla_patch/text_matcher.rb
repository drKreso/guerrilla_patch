class TextMatcher

  def self.match(source, target)
    result = {}
    source.each_pair { |key,value| source[key] = value.gsub(' ', '').downcase }
    target.each_pair { |key,value| target[key] = value.gsub(' ', '').downcase }

    indexed_source = source.each_value.map {|value| value}
    indexed_target = target.each_value.map {|value| value}

    total_count = indexed_target.count
    matched_text = ''
    index = 0
    source_index = 0
    indexes = []
    while(index < total_count)

      if indexed_target[index] == indexed_source[index]
        result[index] = [index]
        matched_text = ''
        index += 1
        indexes = []
      elsif indexed_source[source_index] == nil
        result[index] = indexes
        matched_text = ''
        indexes = []
        index += 1
      elsif indexed_target[index] == matched_text
        result[index] = indexes
        indexes = []
        index += 1
      else
        matched_text += indexed_source[source_index]
      end

      indexes << source_index
      source_index += 1
    end
    #map real ids
    target_as_pairs = target.map {|key, value| [key, value]}
    source_as_pairs = source.map {|key, value| [key, value]}
    real_result = {}
    result.each_pair do |target_index, source_indexes|
      real_result[target_as_pairs[target_index][0]] = source_indexes.map { |source_index| source_as_pairs[source_index][0] }
    end

    real_result
  end

end
