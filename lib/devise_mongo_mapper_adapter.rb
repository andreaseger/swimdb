module Devise
  module Orm
    module MongoMapper
      module Hook
        def devise_modules_hook!
          extend Schema
          include Compatibility
          yield
          return unless Devise.apply_schema
          devise_modules.each { |m| send(m) if respond_to?(m, true) }
        end
      end

      module Schema
        include Devise::Schema

        # Tell how to apply schema methods
        def apply_devise_schema(name, type, options={})
          # type = Time if type == DateTime
          key name, type, options
        end
      end

      module Compatibility
        extend ActiveSupport::Concern

        module ClassMethods
          def find_for_authentication(conditions)
            # find(:first, :conditions => conditions)
            first(conditions)
          end

          # Find an initialize a record setting an error if it can't be found.
          def find_or_initialize_with_error_by(attribute, value, error=:invalid) #:nodoc:
            if value.present?
              conditions = { attribute => value }
              record = first(conditions) # find(:first, :conditions => conditions)
            end

            unless record
              record = new
              if value.present?
                record.send(:"#{attribute}=", value)
              else
                error = :blank
              end
              record.errors.add(attribute, error)
            end

            record
          end

          # Recreate the user based on the stored cookie
          def serialize_from_cookie(id, remember_token)
            conditions = { :id => id, :remember_token => remember_token }

            record = first(conditions) # find(:first, :conditions => conditions)

            record if record && !record.remember_expired?
          end

        end
      end # Compatibility

    end # MongoMapper
  end # Orm
end # Devise

#class Warden::SessionSerializer
#  def deserialize(keys)
#    klass, id = keys
#    klass.constantize.find(id)
#  end
#end

MongoMapper::Document.append_extensions(Devise::Models)
MongoMapper::Document.append_extensions(Devise::Orm::MongoMapper::Hook)



# the sample user.rb
# class User
#   include MongoMapper::Document
#   timestamps!
#   devise :database_authenticatable, :registerable, :validatable
# end

