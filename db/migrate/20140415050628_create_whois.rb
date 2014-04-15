class CreateWhois < ActiveRecord::Migration
  def change
    create_table :whois do |t|
      t.string :country
      t.string :state
      t.string :asn
      t.text :registrant

      t.timestamps
    end
  end
end
