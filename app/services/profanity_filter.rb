class ProfanityFilter
  # Uses the 'language_filter' gem for comprehensive profanity filtering
  # https://github.com/chrisvfritz/language_filter
  
  # Returns true if text contains profanity
  def self.contains_profanity?(text)
    return false if text.blank?
    
    begin
      filter.match?(text)
    rescue => e
      Rails.logger.error("ProfanityFilter error: #{e.message}")
      false # Fail gracefully - don't block operations if filter fails
    end
  end

  # Returns array of profane words found in text
  def self.find_profanity(text)
    return [] if text.blank?
    
    # language_filter doesn't provide a direct method to list matches
    # So we'll return a generic indicator if profanity is detected
    contains_profanity?(text) ? ["inappropriate language detected"] : []
  end

  # Censors profanity by replacing with asterisks
  def self.censor(text)
    return text if text.blank?
    
    begin
      filter.sanitize(text)
    rescue => e
      Rails.logger.error("ProfanityFilter error: #{e.message}")
      text # Return original text if filter fails
    end
  end
  
  private
  
  # Lazily initialize the filter
  def self.filter
    @filter ||= LanguageFilter::Filter.new(matchlist: :profanity, replacement: :stars)
  end
end
