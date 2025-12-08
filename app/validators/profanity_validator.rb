class ProfanityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?
    
    if ProfanityFilter.contains_profanity?(value)
      profane_words = ProfanityFilter.find_profanity(value)
      record.errors.add(
        attribute, 
        options[:message] || "contains inappropriate language (#{profane_words.join(', ')})"
      )
    end
  end
end

