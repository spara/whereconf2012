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


master = []
list = []
comps = []
competitors = get_competitors(ARGV[0])
list.concat(competitors)

for i in 1..3
  list.each do |co|
    comps = comps.concat(get_competitors(co))
    #tags = get_tags(co)
    cat = get_category(co)
    unless cat.nil?
      rec = { co => cat}
      puts "#(i) #{rec}"
      master.push(rec)
    end
  end
  list.concat(comps)
end

#puts master.size
#master.inject([]) { |result,h| result << h unless result.include?(h); result }
#puts master.size

master.each do |rec|
  rec.each do |k,v|
    puts "#{k},#{v}"
 end
end
