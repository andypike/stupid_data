class StupidData
  attr_reader :field_info_factory

  def initialize(connection_string)
    @connection_string = connection_string

    @field_info_factory = FieldInfoFactory.new
  end

  def query(command, klass = :dynamic)
    records = []
    
    conn = PG.connect(@connection_string)
    conn.exec(command) do |rows|
      fields = field_info_factory.create(rows)

      rows.each do |row|
        records << record_factory(klass).create(fields, row)
      end
    end

    records
  end

  private

  def record_factory(klass)
    return DynamicRecordFactory.new if klass == :dynamic  
    return TypedRecordFactory.new(klass)
  end
end
