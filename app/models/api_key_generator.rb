module ApiKeyGenerator

  def self.generate_key
    SecureRandom.hex
  end

end
