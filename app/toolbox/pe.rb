### PEdump Module

require 'pedump'
require 'json/add/struct'

def pedumper(fi)
  fi = File.open(fi)
  pe = PEdump.new

	### Get Compiler
	begin
		data = pe.packer(fi)
		packban = <<-packban
		+-------------------+<br />
		|  Packer/Compiler  |<br />
		+-------------------+<br />
		packban
		packer = "#{data[0]['packer']['name']}<br /><br />"
	rescue
		packer = "Error. Could not get compiler/packer information.<br /><br />"
	end

	### Parse Sections ###
	begin
		data = pe.sections(fi)
		sect = data.to_json
		sections = JSON.parse(sect, :create_additions => true)
		secban = <<-secban
		+----------+<br />
		| Sections |<br />
		+----------+<br />
		secban
		section_headers = "Name\tVirtualSize\tVirtualAddress\tSizeOfRawData\tPointerToRawData<br />"
		section_data = ''
		count = 0
		while count < parsed.length
			par = sections[count]
			section_data += "#{par['Name']}\t#{par['VirtualSize']}\t\t#{par['VirtualAddress']}\t\t#{par['SizeOfRawData']}\t\t#{par['PointerToRawData']}<br />"
			count += 1
		end
	rescue
		section_data = "Error. Could not parse the sections<br />"
  end
  return packban + packer + secban + section_headers + section_data
end



