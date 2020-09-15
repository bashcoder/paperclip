module Paperclip
  class HttpUrlProxyAdapter < UriAdapter
    def self.register
      Paperclip.io_adapters.register self do |target|
        String === target && target =~ REGEXP
      end
    end

    REGEXP = /\Ahttps?:\/\//

    def initialize(target, options = {})
      # escaped = URI.escape(target)
      escaped = Addressable::URI.encode(target)
      # super(URI(target == URI.unescape(target) ? escaped : target), options)
      super(URI(target == Addressable::URI.unencode(target) ? escaped : target), options)
    end
  end
end
