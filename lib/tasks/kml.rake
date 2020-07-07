require 'builder'
require 'json'

# https://developers.google.com/kml

XMLNS = 'http://www.opengis.net/kml/2.2'.freeze

namespace :kml do
  task :generate do
    whiskeys = JSON.parse(File.read(WHISKEY_JSON))

    xml = Builder::XmlMarkup.new(indent: 2, target: STDOUT)
    xml.instruct!

    xml.kml(xmlns: XMLNS) do
      xml.Document do
        whiskeys.each do |whiskey|
          xml.Placemark do
            xml.name whiskey.dig('distiliary', 'name')

            xml.description do
              xml.cdata! <<~HTML.chomp
                <h2>#{whiskey.dig('distiliary', 'location', 'name')}</h2>
              HTML
            end

            xml.Point do
              xml.coordinates whiskey.dig('distiliary', 'location').values_at('longitude', 'latitude').join(',')
            end
          end
        end
      end
    end
  end
end
