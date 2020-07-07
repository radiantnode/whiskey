# frozen_string_literal: true

require 'text-table'
require 'json'

namespace :markdown do
  desc 'Generates a Github-friendly markdown table of whiskeys'
  task :generate, [:update_readme] do
    rows = [HEADINGS, :separator]
    json = JSON.parse(File.read(WHISKEY_JSON))
    json.sort_by! { |w| w.dig('name') }

    rows += json.map do |w|
      [
        '<div align="center">' \
          "<img src=\"images/#{w.dig('bottle_image')}\" height=\"60\">" \
        '</div>',

        w.dig('distillery', 'name'),

        w.dig('distillery', 'location', 'name'),

        "[#{w.dig('name')}](#{w.dig('url')})",

        w.dig('batches')&.map do |b|
          "`#{b.map do |k, v|
            "#{k.split('_').collect(&:capitalize).join(' ')}: #{v}"
          end.join(', ')}`"
        end&.join(', '),

        STAR * w.dig('stars') + EMPTY_STAR * (MAX_STARS - w.dig('stars'))
      ]
    end

    table = Text::Table.new(
      rows: rows,
      boundary_intersection: '|'
    ).to_s.lines[1..-2].join # removes top and bottom borders

    if ENV.has_key?('UPDATE_README')
      puts 'Updating README.'

      readme = File.read(README_FILE)
      readme.gsub!(TABLE_PLACEHOLDER_REGEX, "#{TABLE_PLACEHOLDER_START}\n#{table}#{TABLE_PLACEHOLDER_END}")

      File.open(README_FILE, 'w') { |f| f.puts readme }
    else
      puts table
    end
  end
end
