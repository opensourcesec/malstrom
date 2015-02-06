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
		<br />
		+----------+<br />
		| Sections |<br />
		+----------+<br />
		secban
		section_headers = "NAME&emsp;SIZE&emsp;RVA&emsp;<br />"
		section_data = ''
		count = 0
		while count < sections.length
			par = sections[count]
			section_data += "#{par['Name']}&emsp;&emsp;#{par['SizeOfRawData']}&emsp;&emsp;#{par['VirtualAddress']}<br />"
			count += 1
		end
	rescue
		section_data = "Error. Could not parse the sections<br /><br />"
	end

	begin
		data = pe.resources(fi)
		sect = data.to_json
		resources = JSON.parse(sect, :create_additions => true)
		resban = <<-resban
		<br />
		+-----------+<br />
		| Resources |<br />
		+-----------+<br />
		resban
		resource_headers = "OFFSET &emsp; CP &emsp; LANG &emsp; SIZE &emsp; TYPE &emsp; NAME<br />"
		resource_data = ''
		count = 0
		while count < resources.length
			par = resources[count]
			resource_data += "#{par['file_offset']}&emsp;&emsp;#{par['cp']}&emsp;&emsp;#{par['lang']}&emsp;&emsp;#{par['size']}&emsp;&emsp;#{par['type']}&emsp;&emsp;#{par['name']}<br />"
			count += 1
		end
	rescue
		resource_data = "Error. Could not parse the resources<br /><br />"
	end
  return packban + packer + secban + section_headers + section_data + resban + resource_headers + resource_data
end



