class CreateSocifySashes < ActiveRecord::Migration[5.1]
  def change
    create_table :sashes do |t| # rubocop:disable Style/SymbolProc
      t.timestamps
    end
  end
end
