class TextMatcher

  def self.match(source, target)
    result = {}
    source.each_pair { |key,value| source[key] = value.gsub(' ', '').downcase }
    target.each_pair { |key,value| target[key] = value.gsub(' ', '').downcase }

    mapped_source = source.each_with_index.map { |key_value,index| [index] * key_value[1].size }.flatten(1)
    mapped_target = target.each_with_index.map { |key_value,index| [index] * key_value[1].size }.flatten(1)

    source_clean_chars = source.each_value.map {|v| v}.join('')
    target_clean_chars = target.each_value.map {|v| v}.join('')

    #we have difference so we'll clean up source to match target
    if source_clean_chars != target_clean_chars
      source_index = 0
      target_index = 0
      while(target_index < target_clean_chars.size)
        if source_clean_chars[source_index] == nil
          target_index += 1
        elsif source_clean_chars[source_index] != target_clean_chars[target_index]
          mapped_source.insert(source_index, '-')
          source_index += 1
        else
          source_index += 1
          target_index += 1
        end
        puts target_index
      end
      puts " "
      puts "#{mapped_source}"
      puts "#{mapped_target}"
    end

    (0...mapped_target.size).each do |index|
      if index == "-"
        #nothing should happen
      else
        result[mapped_target[index]] ||= []
        if mapped_source[index] == "-"
          #nothing should happen
        else
          result[mapped_target[index]] << [mapped_source[index]]
        end
      end
    end
    result.each_pair { |key, value| result[key] = value.flatten.uniq }

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
