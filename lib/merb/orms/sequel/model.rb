module Merb
  module Orms
    module Sequel
      module Model

        # This code has been taken from Sequel 3.5.0
        # Sequel::Plugins::ActiveModel
        # http://sequel.rubyforge.org/rdoc-plugins/classes/Sequel/Plugins/ActiveModel.html
        module ActiveModelCompatibility
          # Record that an object was destroyed, for later use by
          # destroyed?
          def after_destroy
            super
            @destroyed = true
          end

          # Whether the object was destroyed by destroy.  Not true
          # for objects that were deleted.
          def destroyed?
            @destroyed == true
          end

          # An alias for new?
          def new_record?
            new?
          end

          # With the ActiveModel plugin, Sequel model objects are already
          # compliant, so this returns self.
          def to_model
            self
          end
        end

      end
    end
  end
end
