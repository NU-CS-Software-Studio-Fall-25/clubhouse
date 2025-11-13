class BackfillEventDefaults < ActiveRecord::Migration[8.0]
  def up
    # description default to empty string
    change_column_default :events, :description, ""

    # backfill existing rows (SQL is robust inside migrations)
    execute <<-SQL.squish
      UPDATE events
      SET description = ''
      WHERE description IS NULL;
    SQL

    # users_attending is serialized (YAML). For Rails serialize(:users_attending, Array)
    # the YAML for an empty array is "--- []\n"
    execute <<-SQL.squish
      UPDATE events
      SET users_attending = '--- []\n'
      WHERE users_attending IS NULL;
    SQL

    # Optionally add a NOT NULL default for the column if you want:
    # WARNING: only do this if you are certain you never rely on NULL.
    # change_column_default :events, :users_attending, '--- []\n'
    # change_column_null :events, :users_attending, false
  end

  def down
    change_column_default :events, :description, nil
    # don't attempt to revert data changes
  end
end
