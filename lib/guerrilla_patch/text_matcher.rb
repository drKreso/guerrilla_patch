class TextMatcher

  def self.match(source, target)
    result = {}
    source.each_pair { |key,value| source[key] = value.gsub(' ', '').downcase.gsub(/\(\d+\)/,'').gsub("\t",'') }
    target.each_pair { |key,value| target[key] = value.gsub(' ', '').downcase.gsub(/\(\d+\)/,'').gsub("\t",'') }

    #clenup both target and source for tokens that don't exist in both
    source_to_delete_key = []
    target_to_delete_key = []

    source_concatenated_temp = source.each_value.map {|v| v}.join('')
    target_concatenated_temp = target.each_value.map {|v| v}.join('')

    source.each_pair do |key, value|
      if target_concatenated_temp.include?(value) == false
        exists = false
        value.scan(/...../).each do |sub_value|
          if target_concatenated_temp.include?(sub_value) == true
            exists = true
          end
        end
        source_to_delete_key << key unless exists
      end
    end
    source_to_delete_key.each do |key|
      source.delete(key)
    end

    target.each_pair do |key, value|
      if source_concatenated_temp.include?(value) == false
        exists = false
        value.scan(/...../).each do |sub_value|
          if source_concatenated_temp.include?(sub_value) == true
            exists = true
          end
        end
        target_to_delete_key << key unless exists
      end
    end

    target_to_delete_key.each do |key|
      target.delete(key)
    end

    mapped_source = source.each_with_index.map { |key_value,index| [index] * key_value[1].size }.flatten(1)
    mapped_target = target.each_with_index.map { |key_value,index| [index] * key_value[1].size }.flatten(1)

    source_concatenated = source.each_value.map {|v| v}.join('')
    target_concatenated = target.each_value.map {|v| v}.join('')

    nil_char_mark = "-"

    #we have difference so we'll clean up so source and target match
    if source_concatenated != target_concatenated
      source_token_index = 0
      target_token_index = 0
      sources_to_match = source.each_value.map {|v| v}
      targets_to_match = target.each_value.map {|v| v}

      while (true) do
        source_token = sources_to_match[source_token_index]
        target_token = targets_to_match[target_token_index]

        break if source_token == nil or target_token == nil or source_concatenated == nil

        if source_token == target_token
          source_token_index += 1
          target_token_index += 1
        else
          if target_concatenated =~ /(^#{Regexp.escape(source_token)}).*/
            if sources_to_match[source_token_index] == target_token
              target_token_index += 1
              #add missing segment from target to source mapper
              current_position = targets_to_match.take(target_token_index - 1).join('').size
              mapped_source.insert(current_position, [nil_char_mark]*target_token.size)
              mapped_source.flatten!(1)
            else
              target_token_index += 1
              #add to source to compensate
              current_position = targets_to_match.take(target_token_index).join('').size
              difference = target_token.size - source_token.size
              if current_position > difference && difference > 0
                mapped_source.insert(current_position - difference, [nil_char_mark]*(difference))
                mapped_source.flatten!(1)
              end
            end
          elsif source_concatenated =~ /(^#{Regexp.escape(target_token)}).*/
            if sources_to_match[source_token_index] == target_token
              source_token_index += 1
              #remove missing segment from source mapper as it does not exist in target
              current_position = targets_to_match.take(target_token_index).join('').size
              mapped_source.slice!(current_position, source_token.size)
            else
              #readjust unmatched token
              sources_to_match[source_token_index] = sources_to_match[source_token_index][target_token.size..-1]
              target_token_index += 1
            end
          elsif source_concatenated =~ /(#{Regexp.escape(target_token)}).*/
            position_index = source_concatenated.index(target_token)
            if position_index < 10
              current_position = targets_to_match.take(target_token_index).join('').size
              mapped_source.slice!(current_position, position_index)
            else
              #too big gap, declare as not found in source
              current_position = targets_to_match.take(target_token_index).join('').size
              mapped_source.insert(current_position, [nil_char_mark]*(target_token.size))
              mapped_source.flatten!(1)
              target_token_index += 1
            end
          elsif target_concatenated =~ /(#{Regexp.escape(source_token)}).*/
            current_position = targets_to_match.take(target_token_index).join('').size
            position_index = target_concatenated.index(source_token)
            if position_index < 10
              mapped_source.insert(current_position, [nil_char_mark]*position_index).flatten!(1)
              target_token_index += 1
            else
              source_token_index += 1
            end
          else
            #ignoring source
            source_token_index += 1
            current_position = targets_to_match.take(target_token_index + 1).join('').size
            mapped_source.slice!(current_position, source_token.size)
          end
        end

        break if source_concatenated == nil or target_concatenated == nil

        source_concatenated = source_concatenated[source_token.size..-1]
        target_concatenated = target_concatenated[target_token.size..-1]

      end
    end

    (0...mapped_target.size).each do |index|
      result[mapped_target[index]] ||= []
      if mapped_source[index] == nil_char_mark
        #nothing should happen
      else
        result[mapped_target[index]] << [mapped_source[index]]
      end
    end

    result.each_pair { |key, value| result[key] = value.flatten.uniq.compact }

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
