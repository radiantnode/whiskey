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

          xml.distillery do
            xml.uuid w.dig('distillery', 'uuid')
            xml.name w.dig('distillery', 'name')

            xml.location do
              xml.name w.dig('distillery', 'location', 'name')
              xml.latitude w.dig('distillery', 'location', 'latitude')
              xml.longitude w.dig('distillery', 'location', 'longitude')
            end
          end

          if w.has_key?('batches')
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
