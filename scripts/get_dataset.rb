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

def get_everything(co)
  data_array = []
  company =Crunchbase::Company.get(co)
  permalink = company.permalink
  fnd_year = company.founded_year
  fnd_month = company.founded_month
  fnd_day = company.founded_day
  total_money_raised = company.total_money_raised
  raised = 0
  funding_rounds = company.funding_rounds
  unless funding_rounds.nil?
    funding_rounds.each do |round|
      raised = raised + round["raised_amount"].to_f
    end
  end
  unless company.acquisition.nil?
    acquiring_company = company.acquisition["acquiring_company"]["name"]
    acquiring_price = company.acquisition["price_amount"]
    acquiring_currency = company.acquisition["price_currency_code"]
    acquiring_source = company.acquisition["source_description"]
    acquiring_year = company.acquisition["acquired_year"]
    acquiring_month = company.acquisition["acquired_month"]
    acquiring_day = company.acquisition["acquired_day"]
  else
    acquiring_company = nil
    acquiring_price = nil
    acquiring_currency = nil
    acquiring_source = nil
    acquiring_year = nil
    acquiring_month = nil
    acquiring_day = nil
  end
  unless company.ipo.nil?
    ipo_valuation = company.ipo["valuation_amount"]
    ipo_currency = company.ipo["valuation_currency_code"]
    ipo_year = company.ipo["pub_year"]
    ipo_month = company.ipo["pub_month"]
    ipo_day = company.ipo["pub_day"]
    ipo_stock_symbol = company.ipo["stock_symbol"]
  end
  deadpooled_year = company.deadpooled_year
  deadpooled_month = company.deadpooled_month
  deadpooled_day = company.deadpooled_day
  data_array = [%Q("#{permalink}"), fnd_year, fnd_month, fnd_day, raised,%Q("#{total_money_raised}"),%Q("#{acquiring_company}"),
                acquiring_price, %Q("#{acquiring_currency}"), %Q("#{acquiring_source}"), acquiring_year, acquiring_month,
                acquiring_day, deadpooled_year, deadpooled_month, deadpooled_day, ipo_valuation, %Q("#{ipo_currency}"),
                ipo_year, ipo_month, ipo_day, %Q("#{ipo_stock_symbol}")]

  return data_array
end

company = ARGV[0]
all = get_everything(ARGV[0])
unless all.nil?
  puts all.join(",")
else
  puts "#{company},nil"
end


