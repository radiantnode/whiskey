# frozen_string_literal: true

require 'builder'
require 'json'

namespace :xml do
  task :generate do
    whiskeys = JSON.parse(File.read(WHISKEY_JSON))

    xml = Builder::XmlMarkup.new(indent: 2, target: STDOUT)
    xml.instruct!

    xml.whiskeys do
      whiskeys.each do |w|
        xml.whiskey do
          xml.uuid w.dig('uuid')
          xml.name w.dig('name')
          xml.url w.dig('url')
          xml.bottle_image w.dig('bottle_image')

          xml.distiliary do
            xml.uuid w.dig('distiliary', 'uuid')
            xml.name w.dig('distiliary', 'name')

            xml.location do
              xml.name w.dig('distiliary', 'location', 'name')
              xml.latitude w.dig('distiliary', 'location', 'latitude')
              xml.longitude w.dig('distiliary', 'location', 'longitude')
            end
          end

          if w.key?('batches')
            xml.batches do
              w.dig('batches').each do |batch|
                xml.batch do
                  batch.each do |key, value|
                    xml.tag!(key, value)
                  end
                end
              end
            end
          end

          xml.stars w.dig('stars')
        end
      end
    end
  end
end
