class NoSqlModel
	include Mongoid::Document

	field :birthday, type: Date
	field :lunchtime, type: Time, default: ->{ Time.now }
	field :apocalypse, type: DateTime
end