WHISKEY_JSON = './formats/json/whiskey.json'
HEADINGS = [
  'Bottle',
  'Distillery',
  'Location',
  'Name',
  'Batch Info (when available)',
  'Rating'
].freeze
STAR = '★'
EMPTY_STAR = '☆'
MAX_STARS = 5
README_FILE = './README.md'
TABLE_PLACEHOLDER_START = '<!-- WHISKEY-TABLE:BEGIN -->'
TABLE_PLACEHOLDER_END = '<!-- WHISKEY-TABLE:END -->'
TABLE_PLACEHOLDER_REGEX = /#{TABLE_PLACEHOLDER_START}[\s\S]*?#{TABLE_PLACEHOLDER_END}/.freeze
