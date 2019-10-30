
def all_dishes()
  conn = PG.connect(dbname: "goodfoodhunting")
  sql = "SELECT * FROM dishes;"
  dishes = conn.exec(sql)
  conn.close
  return dishes
end

def find_one_dish(id)
  conn = PG.connect(dbname: "goodfoodhunting")
  sql = "SELECT * FROM dishes WHERE id = #{id};"
  dish = conn.exec(sql).first # exec always return an array of hashes
  conn.close
  return dish
end

def create_dish(name, image_url)
  conn = PG.connect(dbname: "goodfoodhunting")
  sql =  "INSERT INTO dishes (name, image_url) "
  sql += "VALUES ('#{ name }', '#{ image_url }');"
  conn.exec(sql)
  conn.close  
end

def destroy_dish(id)
  conn = PG.connect(dbname: "goodfoodhunting")
  sql =  "DELETE dishes WHERE id = #{params[:id]};"
  conn.exec(sql)
  conn.close  
end