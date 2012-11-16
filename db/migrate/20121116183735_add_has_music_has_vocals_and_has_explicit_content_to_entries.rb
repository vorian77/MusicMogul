class AddHasMusicHasVocalsAndHasExplicitContentToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :has_music, :boolean, default: true
    add_column :entries, :has_vocals, :boolean, default: true
    add_column :entries, :has_explicit_content, :boolean, default: false
  end
end
