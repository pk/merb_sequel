module Merb
  module Orms
    module Sequel
      module ModelExtensions 
        def new_record?
          self.new?
        end
      end
    end
  end
end
