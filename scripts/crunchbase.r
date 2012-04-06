					
#Crunchbase API: Scrapping Companies info from Crunchbase with R Packages

library(RCurl)

library(RJSONIO)

scrape<-function(company) {
company.base<-paste("http://api.crunchbase.com/v/1/company/",company,".js",sep="")
company.url<-getURL(company.base)
company.parse<-fromJSON(company.url)
# Convert data
year<-ifelse(is.null(company.parse$founded_year),"",company.parse$founded_year)
month<-ifelse(is.null(company.parse$founded_month),"",company.parse$founded_month)
day<-ifelse(is.null(company.parse$founded_day),"",company.parse$founded_day)
created<-ifelse(is.null(company.parse$created_at),"",company.parse$created_at)
employees<-ifelse(is.null(company.parse$number_of_employees),"",company.parse$number_of_employees)
funding_rounds<-ifelse(is.null(company.parse$funding_rounds),"",company.parse$funding_rounds)
investment<-ifelse(is.null(company.parse$investment),"",company.parse$investment)
raised_amount<-ifelse(is.null(company.parse$raised_amount),"",company.parse$raised_amount)
total_raised<-ifelse(is.null(company.parse$total_money_raised),"",company.parse$total_money_raised)
acquisition<-ifelse(is.null(company.parse$acquisition),"",company.parse$acquisition)
price_amount<-ifelse(is.null(company.parse$acquisition$price_amount),"",company.parse$acquisition$price_amount)
acquiring_company<-ifelse(is.null(company.parse$acquisition$acquiring_company),"",company.parse$acquisition$acquiring_company)
acquiring_description<-ifelse(is.null(company.parse$acquisition$source_description),"",company.parse$acquisition$source_description)
acquiring_year<-ifelse(is.null(company.parse$acquisition$acquired_year),"",company.parse$acquisition$acquired_year)
acquiring_month<-ifelse(is.null(company.parse$acquisition$acquired_month),"",company.parse$acquisition$acquired_month)
ipo<-ifelse(is.null(company.parse$ipo),"",company.parse$ipo)
deadpooled_year<-ifelse(is.null(company.parse$deadpooled_year),"",company.parse$deadpooled_year)
deadpooled_month<-ifelse(is.null(company.parse$deadpooled_month),"",company.parse$deadpooled_month)
deadpooled_url<-ifelse(is.null(company.parse$deadpooled_url),"",company.parse$deadpooled_url)
return(c(unlist(company), unlist(year), unlist(month), unlist(day), unlist(created), unlist(employees), unlist(funding_rounds), unlist(investment), unlist(raised_amount), unlist(total_raised), unlist(acquisition), unlist(price_amount),
unlist(acquiring_company), unlist(acquiring_description), unlist(acquiring_year), unlist(acquiring_month), unlist(ipo), unlist(deadpooled_year), unlist(deadpooled_month), unlist(deadpooled_url)))
}

mydata.vectors <- character(0)

conn <- file("test", "r")
while(length(company <- readLines(conn, 1)) > 0) {
    data = as.vector(scrape(company), mode="list")
    mydata.vectors <- c(data, mydata.vectors)
}

close(conn)

