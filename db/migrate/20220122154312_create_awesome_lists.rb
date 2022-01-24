class CreateAwesomeLists < ActiveRecord::Migration[6.0]
  def change
    create_table :awesome_lists do |t|
      t.string :technology
      t.string :category
      t.string :repository
      t.jsonb :project_info

      t.timestamps
    end
  end
end
