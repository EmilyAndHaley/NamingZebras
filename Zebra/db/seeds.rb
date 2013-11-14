require 'nokogiri'

sympFile = File.open("Dataset.xml")
@doc = Nokogiri::XML(sympFile)
sympFile.close()
puts 'hello'
symptomsList = []

@doc.xpath("//DisorderSign").each do |x|
	signId = x.at('ClinicalSign').attribute('id').text()
	name = x.at('ClinicalSign').element_children().text()
	Symptom.where(:name => name, :signid => Integer(signId)).first_or_create
end