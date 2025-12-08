class ProfanityFilter
  # Uses the 'language_filter' gem for comprehensive profanity filtering
  # https://github.com/chrisvfritz/language_filter
  
  # Initialize the filter (done once)
  @filter = LanguageFilter::Filter.new(matchlist: :profanity, replacement: :stars)
  
  # Returns true if text contains profanity
  def self.contains_profanity?(text)
    return false if text.blank?
    @filter.match?(text)
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
    @filter.sanitize(text)
  end
end
