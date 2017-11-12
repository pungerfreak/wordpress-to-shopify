class CreatePostsTags < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up do
        create_table :posts_tags do |t|
          t.integer :post_id
          t.integer :tag_id
        end

        # Damn composite primary key requires migrating data to simpler table
        execute "INSERT INTO posts_tags (post_id, tag_id) SELECT object_id, term_taxonomy_id FROM wp_term_relationships;"
      end
    end
  end
end
