module ActionDispatch
  class Cookies
    class CookieJar
      def fetch(key, *fallback)
        if has_key?(key)
          self.[](key)
        elsif fallback.present?
          fallback
        else
          raise KeyError, "Key not found. Could not find #{key} in cookies Hash."
        end
      end
    end
  end
end
