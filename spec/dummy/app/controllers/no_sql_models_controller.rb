class NoSqlModelsController < ApplicationController
	def new
		@no_sql_model = NoSqlModel.new
	end
end