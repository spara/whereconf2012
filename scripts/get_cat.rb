require "crunchbase"

def get_competitors(co)
  list = []
  company = Crunchbase::Company.get(co)
  competitors = company.competitions.to_ary
  competitors.each do |comp|
   c = comp["competitor"]["permalink"]
   list.push(c)
  end
  return list
end

def get_tags(co)
  company = Crunchbase::Company.get(co)
  tags = company.tag_list
  return tags
end

def get_category(co)
  company = Crunchbase::Company.get(co)
  cat = company.category_code
  return cat
end


company = ARGV[0]
cat = get_category(ARGV[0])
unless cat.nil?
  puts "#{company},#{cat}"
else
  puts "#{company},nil"
end


