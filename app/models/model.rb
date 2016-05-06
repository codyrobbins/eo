class Model
  # Includes.
  include(ActiveModel::Model,
          ActiveModel::Conversion)

  # Retrieval.
  public

    def self.find(json)
      new(parse_json(json))
    end

    def self.build(json)
      build_from_attributes(parse_json(json))
    end

  protected

    def self.parse_json(json)
      JSON.parse(json, symbolize_names: true)
    end

    def self.build_from_attributes(attributes)
      attributes.collect do |attributes|
        new(attributes)
      end
    end

  # Persistence.
  public

    def persisted?
      true
    end

  # Image URLs.
  public

    def image_url(images)
      images.try(:dig, 0, :url)
    end
end