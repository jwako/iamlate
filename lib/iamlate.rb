require "iamlate/api_handler"
require "iamlate/exception"

module Iamlate
  # Store global config objects here - e.g, urls, etc.
  module Config
    # API url endpoints; replace the version at function call time to
    # allow for function-by-function differences in versioning.
    API_HOST = 'api.tokyometroapp.jp'
    VERSION = '0.0.1'
  end
end
