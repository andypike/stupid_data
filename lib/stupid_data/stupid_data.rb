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
    conn.close

    records
  end

  def count(command)
    return query(command).first.count
  end

  def insert(object)
    update_or_insert(object) do |field_names, table_name|
      subs = 1.upto(field_names.count).map {|x| "$#{x}"}
      command = "insert into #{table_name} (#{field_names.join(',')}) values (#{subs.join(',')}) returning id;"
    end
  end

  def update(object)
    update_or_insert(object) do |field_names, table_name|
      subs = field_names.each_with_index.map{ |field_name, x| "#{field_name} = $#{x+1}" }
      "update #{table_name} set #{subs.join(',')} where id = #{object.id} returning id;"      
    end
  end

  def delete
    raise "Not implemented"
  end

  private

  def record_factory(klass)
    return DynamicRecordFactory.new if klass == :dynamic  
    return TypedRecordFactory.new(klass)
  end

  def update_or_insert(object)
    table_name = object.class.name.downcase.pluralize
    fields = query("select column_name from INFORMATION_SCHEMA.COLUMNS where table_name = '#{table_name}' and column_name <> 'id';")
    raise "There isn't a table called '#{table_name}' and so insert failed." if fields.empty?    

    field_names = fields.map(&:column_name) & object.methods.map(&:to_s)
    values = field_names.map { |fn| object.send(fn) }

    command = yield(field_names, table_name)

    conn = PG.connect(@connection_string)
    conn.exec_params(command, values) do |result|
      object.id = result.first["id"].to_i
    end
    conn.close
  end
end
