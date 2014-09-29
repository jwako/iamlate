require 'securerandom'

module Iamlate
  module TokenResource
    TOKEN_LENGTH = 10

    module ClassMethods
      def token_access(column=:code, options={})
        opts = { :length => TOKEN_LENGTH }.merge(options)

        # generate access token
        define_method :_generate_access_token do
          begin
            self.send("#{column}=", _random_token(opts[:length]))
          end while self.class.exists?(column => self[column])
        end
        private :_generate_access_token

        self.__send__(:include, Methods)
        self.before_create :_generate_access_token
        self.validates_uniqueness_of column
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    module Methods
      private

      def _random_token(token_length)
        SecureRandom.urlsafe_base64 token_length
      end
    end

  end
end

ActiveRecord::Base.class_eval { include Iamlate::TokenResource }
