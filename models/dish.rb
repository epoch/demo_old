def all_dishes()
  return run_sql("SELECT * FROM dishes;")
end

def find_one_dish(id)
  return run_sql("SELECT * FROM dishes WHERE id = #{id};").first
end

def update_dish(id, name, image_url)
  sql = <<~SQL
    update dishes 
    set name = '#{ name }', image_url = '#{ image_url }' 
    where id = #{id};
  SQL
  run_sql(sql)
end

def create_dish(name, image_url)
  sql = <<~SQL
    INSERT INTO dishes (name, image_url) 
    VALUES ('#{ name }', '#{ image_url }');
  SQL
  return run_sql(sql)
end

def destroy_dish(id)
  return run_sql("DELETE from dishes WHERE id = #{id};")
end