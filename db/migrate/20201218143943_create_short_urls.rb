class CreateShortUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :short_urls do |t|
      t.string :original_url, null: false
      t.string :slug, null: false
      t.integer :visits, default: 0
      t.string :title

      t.timestamps
    end
    add_index :short_urls, %i[slug original_url], unique: true
  end
end
