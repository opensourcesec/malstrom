class CreateWhois < ActiveRecord::Migration[4.2]
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
