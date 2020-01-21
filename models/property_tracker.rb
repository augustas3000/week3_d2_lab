require 'pg'

class Property

  attr_accessor :address, :value, :number_of_bedrooms, :year, :buy_let_status, :square_footage, :build

  attr_reader :id

  def initialize(options_hash)
    @id = options_hash['id'].to_i if options_hash['id']

    @address = options_hash['address']
    @value = options_hash['value'].to_i
    @number_of_bedrooms = options_hash['number_of_bedrooms'].to_i
    @year = options_hash['year'].to_i
    @buy_let_status = options_hash['buy_let_status']
    @square_footage = options_hash['square_footage'].to_i
    @build = options_hash['build']

  end

  # CRUD:
  # Create:
  def save()
    db = PG.connect({dbname: 'properties_db', host: 'localhost'})

      sql = "INSERT INTO properties
      (address, value, number_of_bedrooms, year, buy_let_status, square_footage, build)

      VALUES ($1, $2, $3, $4, $5, $6, $7)  RETURNING *"

      values = [@address, @value, @number_of_bedrooms, @year, @buy_let_status, @square_footage, @build]

     db.prepare("save", sql)

    @id = db.exec_prepared("save", values)[0]["id"].to_i

    db.close
  end

  # read:
  def Property.all()

    db = PG.connect({dbname: 'properties_db', host: 'localhost'})

    sql = "SELECT * FROM properties"

    db.prepare("all", sql)
    properties = db.exec_prepared("all")
    db.close

    return properties.map{ |property| Property.new(property) }

  end

  # delete:
   def Property.delete_all()
     db = PG.connect({dbname: 'properties_db', host: 'localhost'})
     sql = "DELETE FROM properties"
     db.prepare("delete_all", sql)
     db.exec_prepared("delete_all")
     db.close
   end

   def delete()
     db = PG.connect({dbname: 'properties_db', host: 'localhost'})
     sql = "DELETE FROM properties WHERE id = $1"
     values = [@id]
     db.prepare("delete_one", sql)
     db.exec_prepared("delete_one", values)
     db.close
   end

   def update()
     db = PG.connect({dbname: 'properties_db', host: 'localhost'})
     sql = "UPDATE properties
            SET (address, value, number_of_bedrooms, year, buy_let_status, square_footage, build) = ($1, $2, $3, $4, $5, $6, $7)
            WHERE id = $8"
            values = [@address, @value, @number_of_bedrooms, @year, @buy_let_status, @square_footage, @build, @id]

     db.prepare("update", sql)
     db.exec_prepared("update", values)
     db.close
    end

    def Property.find_by_id(id_to_look_for)
      db = PG.connect({dbname: 'properties_db', host: 'localhost'})

      sql = "SELECT * FROM properties WHERE id = $1"
      values = [id_to_look_for]

      db.prepare("find_by_id", sql)
      property = db.exec_prepared("find_by_id", values)
      db.close

      return property.map{ |property| Property.new(property) }
    end

    def Property.find_by_address(address)

      db = PG.connect({dbname: 'properties_db', host: 'localhost'})

      sql = "SELECT * FROM properties WHERE address = $1"
      values = [address]

      db.prepare("find_by_address", sql)
      property = db.exec_prepared("find_by_address", values)
      db.close

      return property.map{ |property| Property.new(property) }

    end

end
