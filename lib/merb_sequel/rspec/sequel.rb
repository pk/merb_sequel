class Spec::Example::ExampleGroup
  def execute(*args, &block)
    x = nil
    Sequel::Model.db.transaction{x = super(*args, &block); raise Sequel::Error::Rollback}
    x
  end
end
