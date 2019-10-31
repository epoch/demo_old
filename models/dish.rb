
def run_sql(sql)
  conn = PG.connect(ENV['DATABASE_URL'] || { dbname: "goodfoodhunting" })
  records = conn.exec(sql)
  conn.close
  return records
end

def all_dishes()
  return run_sql("SELECT * FROM dishes;")
end

def find_one_dish(id)
  return run_sql("SELECT * FROM dishes WHERE id = #{id};").first
end

def create_dish(name, image_url)
  sql =  "INSERT INTO dishes (name, image_url) "
  sql += "VALUES ('#{ name }', '#{ image_url }');"
  return run_sql(sql)
end

def destroy_dish(id)
  return run_sql("DELETE from dishes WHERE id = #{id};")
end