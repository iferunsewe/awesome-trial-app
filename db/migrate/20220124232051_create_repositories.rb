class CreateRepositories < ActiveRecord::Migration[6.0]
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :owner
      t.jsonb :project_info

      t.timestamps
    end

    add_reference :repositories, :category, foreign_key: true, index: true
  end
end
